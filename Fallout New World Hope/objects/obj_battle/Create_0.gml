/// @description
// Deactivate field objects
instance_deactivate_all(true);

units = [];
turn = 0;
unit_turn_order = [];
unit_render_order = [];

turn_count = 0;
round_count = 0;
battle_wait_time_frames = 30;
battle_wait_time_remaining = 0;
current_user = noone;
current_action = -1;
current_targets = noone;

// Make enemies
for (var _i = 0; _i < array_length(enemies); _i++)
{
	// TO-DO: Replace magic numbers here
	enemy_units[_i] = instance_create_depth(x + 250 + (_i * 10), y + 68 + (_i * 20), depth - 10, obj_battle_units_enemy, enemies[_i]);
	array_push(units, enemy_units[_i]);
}

// Make party
for (var _i = 0; _i < array_length(global.party); _i++)
{
	// TO-DO: Replace magic numbers here
	party_units[_i] = instance_create_depth(x + 70 + (_i * 10), y + 68 + (_i * 15), depth - 10, obj_battle_units_player, global.party[_i]);
	array_push(units, party_units[_i]);
}

// Shuffle turn order
unit_turn_order = array_shuffle(units);

// Get render order
// This function uses the y position of units to determine their 'depth'
// so that they can be drawn correctly when overlapping
refresh_render_order = function()
{
	unit_render_order = [];
	array_copy(unit_render_order, 0, units, 0, array_length(units));
	array_sort(unit_render_order, function(_1, _2)
	{
		return _1.y - _2.y;
	});
}
refresh_render_order();

function battle_state_select_action()
{
	if (!instance_exists(obj_menu))
	{
		// Get current unit
		var _unit = unit_turn_order[turn];
	
		// Is the unit dead or unable to act?
		if (!instance_exists(_unit)) || (_unit.hp <= 0)
		{
			battle_state = battle_state_victory_check;
			exit;
		}
	
		// Select an action to perform
		//begin_action(_unit.id, global.action_library.attack, _unit.id);
	
		// If unit is player controlled:
		if (_unit.object_index == obj_battle_units_player)
		{
			/*
			// Attack random party member
			var _action = global.action_library.attack;
			var _possible_targets = array_filter(obj_battle.enemy_units, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possible_targets[irandom(array_length(_possible_targets) - 1)];
			begin_action(_unit.id, _action, _target);
			*/
			
			// Compile the action menu
			var _menu_options = [];
			var _sub_menus = {};
			
			var _action_list = _unit.actions;
			
			for (var _i = 0; _i < array_length(_action_list); _i++)
			{
				var _action = _action_list[_i];
				var _available = true; // change later for ap cost
				var _name_and_count = _action.name; // change later for item count
				if (_action.sub_menu_val == -1)
				{
					array_push(_menu_options, [_name_and_count, menu_select_action, [_unit, _action], _available]);
				}
				else
				{
					// Create or add to a submenu
					if (is_undefined(_sub_menus[$ _action.sub_menu_val]))
					{
						variable_struct_set(_sub_menus, _action.sub_menu_val, [[_name_and_count, menu_select_action, [_unit, _action], _available]]);
					}
					else
					{
						array_push(_sub_menus[$ _action.sub_menu_val], [[_name_and_count, menu_select_action, [_unit, _action], _available]]);
					}
				}
			}
			
			// Turn sub menus into an array
			var _sub_menus_array = variable_struct_get_names(_sub_menus);
			for (var _i = 0; _i < array_length(_sub_menus_array); _i++)
			{
				// Sort submenu if needed
				// (here)
				
				// Add back option at the end of each submenu
				array_push(_sub_menus[$ _sub_menus_array[_i]], ["Back", menu_go_back, -1, true]);
				// Add submenu into main menu
				array_push(_menu_options, [_sub_menus_array[_i], sub_menu, [_sub_menus[$ _sub_menus_array[_i]]], true]);
			}
				
			menu(x + 10, y + 11, _menu_options, , 74, 60);
		}
		else
		{
			// If unit is AI controlled:
			var _enemy_action = _unit.AI_script();
			if (_enemy_action != -1) begin_action(_unit.id, _enemy_action[0], _enemy_action[1]);
		}
	}
}

function begin_action(_user, _action, _targets)
{
	current_user = _user;
	current_action = _action;
	current_targets = _targets;
	if (!is_array(current_targets)) current_targets = [current_targets];
	battle_wait_time_remaining = battle_wait_time_frames;
	with (_user)
	{
		acting = true;
		// Play user animation if it is defined for that action, and that user
		if (!is_undefined(_action[$ "user_animation"])) && (!is_undefined(_user.sprites[$ _action.user_animation]))
		{
			sprite_index = sprites[$ _action.user_animation];
			image_index = 0;
		}
	}
	battle_state = battle_state_perform_action;
}

function battle_state_perform_action()
{
	// If animation etc is still playing
	if (current_user.acting)
	{
		// When it ends, peform action effect if it exists
		if (current_user.image_index >= current_user.image_number - 1)
		{
			with (current_user)
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
			
			if (variable_struct_exists(current_action, "effect_sprite"))
			{
				if (current_action.effect_on_target == MODE.ALWAYS) || ((current_action.effect_on_target == MODE.VARIES) && (array_length(current_targets) <= 1))
				{
					for (var _i = 0; _i <array_length(current_targets); _i++)
					{
						instance_create_depth(current_targets[_i].x, current_targets[_i].y, current_targets[_i].depth - 1, obj_battle_effect, {sprite_index : current_action.effect_sprite});
					}
				}
				else // Play it at 0, 0
				{
					var _effect_sprite = current_action._effect_spriteif (variable_struct_exists(current_action, "effect_sprite_no_target")) _effect_sprite = current_action.effect_sprite_no_target;
					instance_create_depth(x, y, depth - 100, obj_battle_effect, {sprite_index : _effect_sprite});
				}
			}
			current_action.func(current_user, current_targets);
		}
	}
	else // Wait for delay and then end the turn
	{
		if (!instance_exists(obj_battle_effect))
		{
			battle_wait_time_remaining--
			if (battle_wait_time_remaining == 0)
			{
				battle_state = battle_state_victory_check;
			}
		}
	}
}

function battle_state_victory_check()
{
	battle_state = battle_state_turn_progression;
}

function battle_state_turn_progression()
{
	turn_count++;
	turn++;
	// Loop turns
	if (turn > array_length(unit_turn_order) - 1)
	{
		turn = 0;
		round_count++;
	}
	battle_state = battle_state_select_action;
}

battle_state = battle_state_select_action;