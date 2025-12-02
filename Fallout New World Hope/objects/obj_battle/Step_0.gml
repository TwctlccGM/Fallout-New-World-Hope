/// @description
battle_state();

// End battle when player characters are dead
var _allies = obj_battle.party_units;
if (array_any(_allies, function(_element, _index) {return _element.hp > 0; }) == false) 
{	
	// End battle
	instance_activate_all();
	//instance_destroy(creator);
	//instance_destroy(obj_battle);
	game_restart();
};

// End battle when enemies are dead
var _enemies = obj_battle.enemy_units;
if (array_any(_enemies, function(_element, _index) { return _element.hp > 0; }) == false) 
{	
	instance_activate_all();
	
	// Give item drops to the party
	if (creator.item_drop != -1)
	{
		global.item_array[creator.item_drop][C_ITEM_AMOUNT] += 1;
		new_text_box("Looted a " + string(global.item_array[creator.item_drop][C_ITEM_NAME]), FIELD);
	}
	
	// Find out how much XP to give to the party
	var xp_earned = 0;
	for (var i = 0; i < array_length(_enemies); i++)
	{
		xp_earned += enemy_units[i].xp_yield;
	}
	new_text_box("Earned " + string(xp_earned) + " XP", FIELD);
	
	// Add XP and save party's stats to the global party array
	for (var i = 0; i < array_length(global.party); i++)
	{
		global.party[i].hp		 = party_units[i].hp;
		global.party[i].bet		 = party_units[i].bet;
		global.party[i].xp_total += xp_earned;
		
		// Level up
		if (global.party_data[i].xp_total >= global.party_data[i].xp_to_next_level)
		{
			global.party_data[i].level += 1;
			global.party_data[i].special_points += 1;
			global.party_data[i].perk_points += 1;
			global.party_data[i].hp_max = 100 + (5 * global.party_data[i].endurance * global.party_data[i].level);
			global.party_data[i].hp += 5 * global.party_data[i].endurance;
			global.party_data[i].xp_total -= global.party_data[i].xp_to_next_level;
			global.party_data[i].xp_to_next_level += 100; // TODO: Make exact XP requirements for subequent levels
			new_text_box(global.party_data[i].name + " levelled up!", FIELD);
		}
	}
	
	// Save data to save file
	var _save_data = array_create(0); // Make save array
	for (var i = 0; i < array_length(global.party_data); i++) // Add party member data to the save array
	{
		var _save_entity =	// Make struct
		{
			party				:	global.party,							// Party setup
			saved_room			:	room,									// Room
			party_member		:	global.party_data[i].name,				// Name
			is_recruited		:	global.party_data[i].is_recruited,		// Recruited
			level				:	global.party_data[i].level,				// Level
			hp					:	global.party_data[i].hp,				// HP
			hp_max				:	global.party_data[i].hp_max,			// HP Max
			bet					:	global.party_data[i].bet,				// BET
			strength			:	global.party_data[i].strength,			// STR
			perception			:	global.party_data[i].perception,		// PER
			endurance			:	global.party_data[i].endurance,			// END
			charisma			:	global.party_data[i].charisma,			// CHA
			intelligence		:	global.party_data[i].intelligence,		// INT
			agility				:	global.party_data[i].agility,			// AGI
			luck				:	global.party_data[i].luck,				// LCK
			xp_total			:	global.party_data[i].xp_total,			// XP
			xp_to_next_level	:	global.party_data[i].xp_to_next_level,	// XP to next level
			special_points		:	global.party_data[i].special_points,	// SPECIAL points
			perk_points			:	global.party_data[i].perk_points,		// Perk points
		}
		array_push(_save_data, _save_entity); // Add struct to save array
	}
	// Turn this data into a JSON string and save it via a buffer
	var _string = json_stringify(_save_data);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, "savedgame.save");
	buffer_delete(_buffer);
	
	show_debug_message("Game Saved! " + _string); // Debug message
	
	// End battle
	instance_destroy(obj_battle_floating_text);
	instance_destroy(obj_battle_effect);
	instance_activate_all();
	instance_destroy(creator);
	instance_destroy(obj_battle);
};

// Cursor control
if (cursor.active)
{
	with (cursor)
	{
		// Input
		var _key_up = keyboard_check_pressed(vk_up);
		var _key_down = keyboard_check_pressed(vk_down);
		var _key_left = keyboard_check_pressed(vk_left);
		var _key_right = keyboard_check_pressed(vk_right);
		var _key_toggle = false;
		var _key_confirm = false;
		var _key_cancel = false;
		confirm_delay++;
		if (confirm_delay > 1)
		{
			_key_confirm = keyboard_check_pressed(ord("Z"));
			_key_cancel = keyboard_check_pressed(ord("X"));
			_key_toggle = keyboard_check_pressed(vk_shift);
		}
		var _move_h = _key_right - _key_left;
		var _move_v = _key_down - _key_up;
		
		if (_move_h == -1) target_side = obj_battle.party_units;
		if (_move_h == 1) target_side = obj_battle.enemy_units;
		
		// Verify target list
		if (target_side == obj_battle.enemy_units)
		{
			target_side = array_filter(target_side, function(_element, _index)
			{
				return _element.hp > 0;
			});
		}
		
		// Move between targets
		if (active_action.target_all == MODE.SELF) // Target ONLY self
		{
			target_side = obj_battle.party_units;
			active_target = target_side[target_index];
		}
		else if (target_all == false) // Single target mode
		{
			if (_move_v == 1) target_index++;
			if (_move_v == -1) target_index--;
			
			// Wrap
			var _targets = array_length(target_side);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
			
			// Identify target
			active_target = target_side[target_index];
			
			// Toggle all mode
			if (active_action.target_all == MODE.VARIES) && (_key_toggle) // Switch to all mode
			{
				target_all = true;
			}
		}
		else // Target all mode
		{
			active_target = target_side;
			if (active_action.target_all == MODE.VARIES) && (_key_toggle) // Switch to single mode
			{
				target_all = false;
			}
		}
		
		/// TO-DO: Improve handling for 'not enough AP to use ability'. 
		/// Right now it doesn't display the message and the cursor remains on the enemies.
		
		// Confirm action
		obj_battle.battle_text = string(obj_battle.cursor.active_action.description_new);
		if (_key_confirm)
		{
			with (obj_battle) begin_action(cursor.active_user, cursor.active_action, cursor.active_target);
			if (obj_battle.action_failed == false)
			{
				with (obj_menu) instance_destroy();
				active = false;
				confirm_delay = 0;
			}
			else
			{
				battle_text = string("Not enough AP!");
				obj_battle.action_failed = false;
			}
		}
		
		// Cancel & return to menu
		if (_key_cancel) && (!_key_confirm)
		{
			obj_battle.battle_text = "";
			with (obj_menu) active = true;
			active = false;
			confirm_delay = 0;
		}
	}
}