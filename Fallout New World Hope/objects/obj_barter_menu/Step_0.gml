/// @description
if (state == BARTER_STATE_LOCKED) exit;
// Toggle barter menu
if (draw_barter == true)
{ 
	cursor.active = true;
	global.pause = true; 
	if (keyboard_check_pressed(ord("X"))) // Deactivate barter menu
	{
		draw_barter = false;
		cursor.active = false;
		global.pause = false; 
	}
}

// Make inventory
if keyboard_check_pressed(ord("Z"))
{
	array_delete(global.inventory_array, 0, array_length(global.inventory_array));
	var _i = 0;
	for(var _pos = 0; _pos < array_length(global.item_array); _pos++)
	{
		if (global.item_array[_pos][C_ITEM_AMOUNT] > 0)
		{
			global.inventory_array[_i][C_ITEM_TYPE]				= global.item_array[_pos][C_ITEM_TYPE];
			global.inventory_array[_i][C_ITEM_INVENTORY_SPRITE] = global.item_array[_pos][C_ITEM_INVENTORY_SPRITE];
			global.inventory_array[_i][C_ITEM_AMOUNT]			= global.item_array[_pos][C_ITEM_AMOUNT];
			_i++;
		}
	}
}
		
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
		var _move_h = _key_right - _key_left;
		var _move_v = _key_down - _key_up;
		
		if (array_length(global.barter_array) <= 0) { _move_h = -1; } // Stops error when trying to swap to empty item array
		if (array_length(global.inventory_array) <= 0) { _move_h = -1; } // Stops error when trying to swap to empty item array
		if (_move_h == -1) target_side = global.inventory_array;
		if (_move_h == 1) target_side = global.barter_array;

		// Move between targets
		//if (array_length(global.item_array) == 1 && target_side == global.item_array) { _move_v = 0; } // One item in inventory
		if (_move_v == 1) target_index++;
		if (_move_v == -1) target_index--;
		
		// Wrap
		var _targets = array_length(target_side);
		if (target_index < 0) target_index = _targets - 1;
		if (target_index > (_targets - 1)) target_index = 0;
		
		// Identify target
		if (target_side == global.barter_array) { active_target = target_side[target_index]; }
		if (target_side == global.inventory_array) { active_target = target_side[target_index]; }
		
		// Confirm action
		if (_key_confirm)
		{
			if (target_side == global.barter_array) // Buying an item
			{
				// buy function here
				buy_item(target_index, 0);
				confirm_delay = 0;
			}
			if (target_side == global.inventory_array) // Selling an item
			{
				// sell function here
				confirm_delay = 0;
			}
		}
		
		// Cancel & return to menu
		if (_key_cancel) && (!_key_confirm)
		{
				
		}
	}
}














