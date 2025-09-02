/// @description
battle_state();

// End battle when enemies are dead
var _enemies = obj_battle.enemy_units;
if (array_any(_enemies, function(_element, _index) {return _element.hp > 0; }) == false) 
{
	// Save party data
	var _save_data = array_create(0); // Make save array
	for (var _i = 0; _i < array_length(global.party); _i++) // Add party member data to the save array
	{
		var _save_entity =	// Make struct
		{
			party_member : party_units[_i].name,	// Name
			hp : party_units[_i].hp,				// HP
			ap : party_units[_i].ap,				// AP
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
		if (target_all == false) // Single target mode
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
			with (obj_menu) active = true;
			active = false;
			confirm_delay = 0;
		}
	}
}