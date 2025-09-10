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

battle_text = "";
action_failed = false;

current_user = noone;
current_action = -1;
current_targets = noone;

// Make targeting cursor
cursor = 
{
	active_user: noone,
	active_target: noone,
	active_action: -1,
	target_side: -1,
	target_index: 0,
	target_all: false,
	confirm_delay: 0,
	active: false
};

// Make enemies
for (var i = 0; i < array_length(enemies); i++)
{
	// TO-DO: Replace magic numbers here
	enemy_units[i] = instance_create_depth(x + 250 + (i * 10), y + 68 + (i * 20), depth - 10, obj_battle_units_enemy, enemies[i]);
	array_push(units, enemy_units[i]); // Add enemy units to battle units array
}

/// Old system
/*
// Make party
if (file_exists("savedgame.save")) // Check if there's a save file
{
	var _buffer = buffer_load("savedgame.save"); // Read from the save file using a buffer
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	var _load_data = json_parse(_string); // Turn JSON data into an array of player unit stats
	var _reversed_load_data = array_reverse(_load_data); // Reverse the array to assign stats in correct order
		
	// Edit the global.party data using saved data
	for (var i = 0; i < array_length(global.party); i++) // Loop for each party member
	{
		var _load_entity = array_pop(_reversed_load_data); // Take data from the save data array, then delete it from the array
		global.party[i].hp = _load_entity.hp; // HP
		//global.party[i].ap = _load_entity.ap; // AP
		
		// TO-DO: Replace magic numbers here
		party_units[i] = instance_create_depth(x + 70 + (i * 10), y + 68 + (i * 15), depth - 10, obj_battle_units_player, global.party[i]);
		array_push(units, party_units[i]); // Add player units to battle units array
	}
}
else
{
	// Make party
	for (var i = 0; i < array_length(global.party); i++)
	{
	// TO-DO: Replace magic numbers here
	party_units[i] = instance_create_depth(x + 70 + (i * 10), y + 68 + (i * 15), depth - 10, obj_battle_units_player, global.party[i]);
	array_push(units, party_units[i]);
	}
}
*/

// Make party
	for (var i = 0; i < array_length(global.party); i++)
	{
	// TO-DO: Replace magic numbers here
	party_units[i] = instance_create_depth(x + 70 + (i * 10), y + 68 + (i * 15), depth - 10, obj_battle_units_player, global.party[i]);
	array_push(units, party_units[i]);
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
	
		// If unit is player controlled:
		if (_unit.object_index == obj_battle_units_player)
		{
			battle_change_ap(_unit, 1, 1); // Restore 1 AP each turn
			
			// Compile the action menu
			var _menu_options = [];
			var _sub_menus = {};
			
			var _action_list = _unit.actions;
			
			for (var i = 0; i < array_length(_action_list); i++)
			{
				var _action = _action_list[i];
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
			for (var i = 0; i < array_length(_sub_menus_array); i++)
			{
				// Sort submenu if needed
				// (here)
				
				// Add back option at the end of each submenu
				array_push(_sub_menus[$ _sub_menus_array[i]], ["Back", menu_go_back, -1, true]);
				// Add submenu into main menu
				array_push(_menu_options, [_sub_menus_array[i], sub_menu, [_sub_menus[$ _sub_menus_array[i]]], true]);
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
	
	//battle_text = string_ext(_action.description, [_user.name]);
	if (!is_array(current_targets)) current_targets = [current_targets];
	battle_wait_time_remaining = battle_wait_time_frames;
	
	if (_action.is_item == true) 
	{
		var _type = _action.item_id;
		var _pos = 0;
		while (_pos < 5) // Scan array for if the item type is already in there
		{
			if (global.item_array[_pos, C_ITEM_TYPE] == _type) 
			{ 
				if (global.item_array[_pos, C_ITEM_AMOUNT] <= 0) { action_failed = true; } // Item amount is 0
				else { global.item_array[_pos, C_ITEM_AMOUNT] -= 1; } // Reduce item amount by 1 if item is used
				break; 
			}
			else { _pos += 1; }
			if (_pos >= 5) { action_failed = true; } // Item not present in inventory
		}
	}
	
	if (_user.ap >= _action.ap_cost) && (!action_failed)// Check AP Cost
	{
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
		battle_text = string_ext(_action.description, [_user.name]);
		battle_state = battle_state_perform_action;
	}
	else { action_failed = true; } // Cancel action
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
					for (var i = 0; i <array_length(current_targets); i++)
					{
						instance_create_depth(current_targets[i].x, current_targets[i].y, current_targets[i].depth - 1, obj_battle_effect, {sprite_index : current_action.effect_sprite});
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
	battle_text = ""; // Reset battle text
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