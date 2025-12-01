/// @description
if (state == INVENTORY_STATE_LOCKED) exit;
// Toggle inventory
if (keyboard_check_pressed(vk_tab))
{
	if (draw_inventory == true) // Deactivate inventory
	{ 
		stats_selected = false;
		swap_selected = false;
		party_selected = false;
		stimpak_selected = false;
		doctorsbag_selected = false;
		draw_inventory = false; 
		cursor.active =  false;
		global.pause = false; 
	}
	else if (draw_inventory == false) // Activate inventory
	{ 
		stats_selected = false;
		swap_selected = false;
		party_selected = false;
		stimpak_selected = false;
		doctorsbag_selected = false;
		draw_inventory = true; 
		cursor.active =  true;
		global.pause = true; 
		
		// Dummy stats as default
		cursor.party_member_stats = [
			global.party[PARTY_VAULTIE].strength,
			global.party[PARTY_VAULTIE].perception,
			global.party[PARTY_VAULTIE].endurance,
			global.party[PARTY_VAULTIE].charisma,
			global.party[PARTY_VAULTIE].intelligence,
			global.party[PARTY_VAULTIE].agility,
			global.party[PARTY_VAULTIE].luck
		];
		
		cursor.party_member_options = ["Stats", "Swap"];
		
		// Make inventory
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

// Make list of waiting party members
cursor.party_member_waiting = [];
for (var i = 0; i < array_length(global.party_data); i++) 
{
	if (!is_in_party(global.party_data[i]))
	{
		if (global.party_data[i].is_recruited == true)
		{
			array_push(cursor.party_member_waiting, global.party_data[i]);
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
		if (obj_menu_inventory.stimpak_selected == true) // Using item (like a stimpak), player selects which party member to use it on
		{
			target_side = global.party;
			
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
				obj_menu_inventory.stimpak_selected = false;
			}
		}
		
		/// Using doctors bag
		else if (obj_menu_inventory.doctorsbag_selected == true) // Using item (like a stimpak), player selects which party member to use it on
		{
			target_side = global.party;
			
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
				obj_menu_inventory.doctorsbag_selected = false;
			}
		}
		
		// Party member selected screen
		else if (obj_menu_inventory.party_selected == true)
		{
			if (target_index >= 2) { target_index = 0; }
			if (flag_for_target_index_stuff == false) { target_index = 0; flag_for_target_index_stuff = true; }
			target_side = party_member_options;
			active_target = target_side[target_index];
			
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
				// Stats selected
				if (target_index = 0)
				{
					obj_menu_inventory.stats_selected = true;
					obj_menu_inventory.party_selected = false;
					flag_for_target_index_stuff = false;
				}
				// Swap selected
				if (target_index = 1 && (array_length(party_member_waiting) > 0))
				{
					obj_menu_inventory.swap_selected = true;	
					obj_menu_inventory.party_selected = false;
					flag_for_target_index_stuff = false;
				}
			}
		
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				target_side = global.party;
				target_index = stored_target_index;
				obj_menu_inventory.party_selected = false;
			}
		}
		
		// Party member stats screen
		else if (obj_menu_inventory.stats_selected == true)
		{
			// Make party member's stats
			party_member_stats = [
				global.party[stored_target_index].strength,
				global.party[stored_target_index].perception,
				global.party[stored_target_index].endurance,
				global.party[stored_target_index].charisma,
				global.party[stored_target_index].intelligence,
				global.party[stored_target_index].agility,
				global.party[stored_target_index].luck
			];
			
			target_side = party_member_stats;
			active_target = target_side[target_index];
			
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
				// Add SPECIAL point to a stat, up to 10 maximum
				if (global.party[stored_target_index].special_points > 0) {
					switch (target_index)
				    {
				        case 0: 
							if (global.party[stored_target_index].strength			< 10)
							{
								global.party[stored_target_index].strength			+= 1;
								global.party[stored_target_index].special_points	-= 1;
							}
							break;
				        case 1: 
							if (global.party[stored_target_index].perception		< 10) 
							{	
								global.party[stored_target_index].perception		+= 1; 
								global.party[stored_target_index].special_points	-= 1;
							}
							break;
				        case 2: 
							if (global.party[stored_target_index].endurance			< 10)
							{
								global.party[stored_target_index].endurance			+= 1; 
								global.party[stored_target_index].special_points	-= 1;
							}
						break;
				        case 3: 
							if (global.party[stored_target_index].charisma			< 10)
							{
								global.party[stored_target_index].charisma			+= 1; 
								global.party[stored_target_index].special_points	-= 1;
							}
						break;
				        case 4: 
							if (global.party[stored_target_index].intelligence		< 10)
							{
								global.party[stored_target_index].intelligence		+= 1; 
								global.party[stored_target_index].special_points	-= 1;
							}
						break;
				        case 5: 
							if (global.party[stored_target_index].agility			< 10)
							{
								global.party[stored_target_index].agility			+= 1; 
								global.party[stored_target_index].special_points	-= 1;
							}
						break;
				        case 6: 
							if (global.party[stored_target_index].luck				< 10)
							{
								global.party[stored_target_index].luck				+= 1; 
								global.party[stored_target_index].special_points	-= 1;
							}
						break;
				    }
				}
			}
		
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				target_side = global.party;
				target_index = stored_target_index;
				obj_menu_inventory.stats_selected = false;
			}
		}
		
		// Party member swap screen
		else if (obj_menu_inventory.swap_selected == true)
		{
			target_side = party_member_waiting;
			active_target = 0;//target_side[target_index];
			
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
				if (array_length(global.party) <= 2) // Party not full
				{
					array_insert(global.party, array_length(global.party), global.party_data[party_member_waiting[target_index].party_name]);
				}
				else if (array_length(global.party) > 2) // Party full
				{
					array_delete(global.party, stored_target_index, 1);
					array_insert(global.party, stored_target_index, global.party_data[party_member_waiting[target_index].party_name]);
					//array_delete(global.party, stored_target_index + 1, 1);
				}
				// Re-make party
				
			}
		
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				target_side = global.party;
				target_index = stored_target_index;
				obj_menu_inventory.swap_selected = false;
			}
			
			// No party members on standby
			if (array_length(party_member_waiting) <= 0)
			{
				target_side = global.party;
				target_index = stored_target_index;
				obj_menu_inventory.swap_selected = false;
			}
		}
		
		else
		{
			if (array_length(global.inventory_array) <= 0) { _move_h = -1; } // Stops error when trying to swap to empty item array
			if (_move_h == -1) target_side = global.party;
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
			if (target_side == global.party) { active_target = target_side[target_index]; }
		
			// Confirm action
			if (_key_confirm)
			{
				if (target_side == global.inventory_array) // Using an item
				{
					if (target_side[target_index][C_ITEM_TYPE] == ITEM_STIMPAK) // Using a stimpak
					{
						stored_target_index = target_index;		// Stores target index to display 'locked' pointer finger in Draw event
						obj_menu_inventory.stimpak_selected = true;	// Variable used in other events to activate 'usingitem' logic
						confirm_delay = 0;
					}
					if (target_side[target_index][C_ITEM_TYPE] == ITEM_DOCTORSBAG) // Using a doctors bag
					{
						stored_target_index = target_index;			// Stores target index to display 'locked' pointer finger in Draw event
						obj_menu_inventory.doctorsbag_selected = true;	// Variable used in other events to activate 'using item' logic
						confirm_delay = 0;
					}
				}
				if (target_side == global.party) // Looking at party member stats
				{
					stored_target_index = target_index;
					obj_menu_inventory.party_selected = true;
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







