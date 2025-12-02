/// @description
		
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
		if (confirm_delay > 2)
		{
			_key_confirm = keyboard_check_pressed(ord("Z"));
			_key_cancel = keyboard_check_pressed(ord("X"));
			_key_toggle = keyboard_check_pressed(vk_shift);
		}
		var _move_v = _key_down - _key_up;

		// Move between targets
		if (_move_v == 1) target_index++;
		if (_move_v == -1) target_index--;
		
		// Wrap
		var _targets = array_length(obj_menu_title.title_menu_options);
		if (target_index < 0) target_index = _targets - 1;
		if (target_index > (_targets - 1)) target_index = 0;
		
		// Confirm action
		if (_key_confirm)
		{
			switch target_index
			{
				case NEW_GAME:
					// new game script here
					room_goto(rm_field_y17);
					break;
				case LOAD_GAME:
					// load game script here
					if (file_exists("savedgame.save")) // Check if there's a save file
					{
						var _buffer = buffer_load("savedgame.save"); // Read from the save file using a buffer
						var _string = buffer_read(_buffer, buffer_string);
						buffer_delete(_buffer);
	
						var _load_data = json_parse(_string); // Turn JSON data into an array of player unit stats
						var _reversed_load_data = array_reverse(_load_data); // Reverse the array to assign stats in correct order
						var _saved_room = rm_overworld;
						// Edit the global.party_data using saved data
						for (var i = 0; i < array_length(global.party_data); i++) // Loop for each party member
						{
							var _load_entity = array_pop(_reversed_load_data); // Take data from the save data array, then delete it from the array
												global.party		= _load_entity.party;				// Party setup
												_saved_room			= _load_entity.saved_room;			// Room
							global.party_data[i].level				= _load_entity.level;				// Level
							global.party_data[i].is_recruited		= _load_entity.is_recruited;		// Recruited
							global.party_data[i].hp					= _load_entity.hp;					// HP
							global.party_data[i].hp_max				= _load_entity.hp_max;				// HP Max
							global.party_data[i].bet				= _load_entity.bet;					// BET
							global.party_data[i].strength			= _load_entity.strength;			// STR
							global.party_data[i].perception			= _load_entity.perception;			// PER
							global.party_data[i].endurance			= _load_entity.endurance;			// END
							global.party_data[i].charisma			= _load_entity.charisma;			// CHA
							global.party_data[i].intelligence		= _load_entity.intelligence;		// INT
							global.party_data[i].agility			= _load_entity.agility;				// AGI
							global.party_data[i].luck				= _load_entity.luck;				// LCK
							global.party_data[i].xp_total			= _load_entity.xp_total;			// XP
							global.party_data[i].xp_to_next_level	= _load_entity.xp_to_next_level	;	// XP to next level
							global.party_data[i].special_points		= _load_entity.special_points;		// SPECIAL points
							global.party_data[i].perk_points		= _load_entity.perk_points;			// Perk points
						}
						room_goto(_saved_room);
					}
					else
					{
						show_debug_message("Load failed, save file doesn't exist");
					}
					break;
				case OPTIONS:
					// options script here
					break;
				case QUIT:
					game_end();
					break;
				default:
					show_debug_message("Title menu switch statement error");
			}
		}
		
		// Cancel & return to menu
		if (_key_cancel) && (!_key_confirm)
		{
				
		}
	}
}














