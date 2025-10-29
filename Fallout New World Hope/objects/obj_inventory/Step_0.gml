/// @description
// Toggle inventory
if (keyboard_check_pressed(vk_tab))
{
	if (draw_inventory == true) // Deactivate inventory
	{ 
		party_selected = false;
		stimpak_selected = false;
		doctorsbag_selected = false;
		draw_inventory = false; 
		cursor.active =  false;
		global.pause = false; 
	}
	else if (draw_inventory == false) // Activate inventory
	{ 
		party = [];
		// Make party
		for (var i = 0; i < array_length(global.party); i++)
		{
			// TO-DO: Replace magic numbers here
			party_units[i] = instance_create_depth(x + 70 + (i * 10), y + 68 + (i * 15), depth + 10, obj_battle_units_player, global.party[i]);
			array_push(party, party_units[i]);
		}

		party_selected = false;
		stimpak_selected = false;
		doctorsbag_selected = false;
		draw_inventory = true; 
		cursor.active =  true;
		global.pause = true; 
		
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
			// _yy += 25;
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
		
		/// Using stimpak
		if (obj_inventory.stimpak_selected == true) // Using item (like a stimpak), player selects which party member to use it on
		{
			target_side = obj_inventory.party;
			
			// Move between targets
			if (_move_v == 1) target_index++;
			if (_move_v == -1) target_index--;
			
			// Wrap
			var _targets = array_length(target_side);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
			
			// Confirm action
			if (_key_confirm)
			{
				use_item(ITEM_STIMPAK, target_index);
			}
		
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				obj_inventory.stimpak_selected = false;
			}
		}
		
		/// Using doctors bag
		else if (obj_inventory.doctorsbag_selected == true) // Using item (like a stimpak), player selects which party member to use it on
		{
			target_side = obj_inventory.party;
			
			// Move between targets
			if (_move_v == 1) target_index++;
			if (_move_v == -1) target_index--;
			
			// Wrap
			var _targets = array_length(target_side);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
			
			// Confirm action
			if (_key_confirm)
			{
				use_item(ITEM_DOCTORSBAG, target_index);
			}
		
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				obj_inventory.doctorsbag_selected = false;
			}
		}
		else if (obj_inventory.party_selected == true)
		{
			target_side = obj_inventory.party;
			
			// Move between targets
			if (_move_v == 1) target_index++;
			if (_move_v == -1) target_index--;
			
			// Wrap
			var _targets = array_length(target_side);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
		
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				obj_inventory.party_selected = false;
			}
		}
		else
		{
			if (array_length(global.inventory_array) <= 0) { _move_h = -1; } // Stops error when trying to swap to empty item array
			if (_move_h == -1) target_side = obj_inventory.party;
			if (_move_h == 1) target_side = global.inventory_array;
		
			// Move between targets
			//if (array_length(global.item_array) == 1 && target_side == global.item_array) { _move_v = 0; } // One item in inventory
			if (_move_v == 1) target_index++;
			if (_move_v == -1) target_index--;
		
			// Wrap
			var _targets = array_length(target_side);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
		
			// Identify target
			if (target_side == global.inventory_array) { active_target = target_side[target_index]; }
			if (target_side == obj_inventory.party) { active_target = target_side[target_index]; }
		
			// Confirm action
			if (_key_confirm)
			{
				if (target_side == global.inventory_array) // Using an item
				{
					if (target_side[target_index][C_ITEM_TYPE] == ITEM_STIMPAK) // Using a stimpak
					{
						stored_target_index = target_index;		// Stores target index to display 'locked' pointer finger in Draw event
						obj_inventory.stimpak_selected = true;	// Variable used in other events to activate 'usingitem' logic
						confirm_delay = 0;
					}
					if (target_side[target_index][C_ITEM_TYPE] == ITEM_DOCTORSBAG) // Using a doctors bag
					{
						stored_target_index = target_index;			// Stores target index to display 'locked' pointer finger in Draw event
						obj_inventory.doctorsbag_selected = true;	// Variable used in other events to activate 'using item' logic
						confirm_delay = 0;
					}
				}
				if (target_side == obj_inventory.party) // Looking at party member stats
				{
					obj_inventory.party_selected = true;
					confirm_delay = 0;
				}
			}
		
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				
			}
		}
	}
}







