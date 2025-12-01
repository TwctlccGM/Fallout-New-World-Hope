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














