/// @description
//draw_self();
//var _item_x = item_pos * 22;
//var _xx = obj_camera.x - 160;
//var _yy = obj_camera.y - 50;

//draw_set_font(fnt_monofonto);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _items_xx = obj_camera.x;
var _party_xx = obj_camera.x - 160;
var _yy = obj_camera.y - 90;

if (keyboard_check_pressed(vk_tab)) // Toggle inventory
{
	if (draw_inventory == true) // Deactivate inventory
	{ 
		stimpak_selected = false;
		doctorsbag_selected = false;
		draw_inventory = false; 
		cursor.active =  false;
		global.pause = false; 
	}
	else if (draw_inventory == false) // Activate inventory
	{ 
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

// Draw the inventory
if (draw_inventory == true) 
{ 
	/// Draw inventory tab
	_yy = obj_camera.y - 90;
	
	draw_sprite_stretched(spr_textbox_ph, 0, _items_xx, _yy, 160, 180);
	draw_set_font(fnt_fixedsys);
	draw_text(_items_xx + 5, _yy + 5, "ITEMS");
	for(var _pos = 0; _pos < array_length(global.inventory_array); _pos++)
    {
		//if (global.item_array[_pos, C_ITEM_AMOUNT] > 0)
        //{
			draw_sprite(global.inventory_array[_pos, C_ITEM_INVENTORY_SPRITE], 0, _items_xx + 20, _yy + 40);
			draw_text(_items_xx + 35, _yy + 30, string(global.inventory_array[_pos, C_ITEM_AMOUNT]));
			_yy += 25;
        //}
		// _yy += 25;
	}
	
	/// Draw party info tab
	_yy = obj_camera.y - 90;
	
	draw_sprite_stretched(spr_textbox_ph, 0, _party_xx, _yy, 160, 180);
	draw_set_font(fnt_fixedsys);
	draw_text(_party_xx + 5, _yy + 5, "PARTY");
	for(var _pos = 0; _pos < array_length(global.party); _pos++)
    {
		draw_sprite(global.party[_pos].sprites.inventory, 0, _party_xx + 35, _yy + 45);
		draw_text(_party_xx + 68, _yy + 30, "HP:" + string(global.party[_pos].hp) + "/" + string(global.party[_pos].hp_max));
		draw_healthbar(_party_xx + 95, _yy + 45, _party_xx + 145, _yy + 46, global.party[_pos].hp, c_gray, c_red, c_green, 0, true, false);
		_yy += 50;
	}
	
	//draw_sprite(spr_pointer_ph, 0, _xx, _yy);
}

// Draw target cursor
if (cursor.active)
{
	with (cursor)
	{
		//if (active_target != noone)
		//{
			//if (!is_array(active_target)) // Single target
			//{
			if (target_side = global.inventory_array)
			{
				_yy = obj_camera.y - 90;
				draw_set_color(c_white)
				draw_rectangle(_items_xx + 10, _yy + (target_index * 25) + 30, _items_xx + 52, _yy + (target_index * 25) + 50, true)
				draw_sprite(spr_pointer_ph, 0, _items_xx, _yy + (target_index * 25) + 25);
			}
			
			if (target_side = obj_inventory.party)
			{
				_yy = obj_camera.y - 90;
				draw_set_color(c_white)
				draw_rectangle(_party_xx + 10, _yy + (target_index * 50) + 25, _party_xx + 150, _yy + (target_index * 50) + 65, true)
				draw_sprite(spr_pointer_ph, 0, _party_xx, _yy + (target_index * 50) + 25);
			}
			
			if (obj_inventory.stimpak_selected)
			{
				_yy = obj_camera.y - 90;
				draw_set_color(c_white)
				draw_sprite(spr_pointer_ph, 0, _items_xx, stored_target_index * 25 + 25);
			}
			
			if (obj_inventory.doctorsbag_selected)
			{
				_yy = obj_camera.y - 90;
				draw_set_color(c_white)
				draw_sprite(spr_pointer_ph, 0, _items_xx, stored_target_index * 25 + 25);
			}
			//}
		//}
	}
}



