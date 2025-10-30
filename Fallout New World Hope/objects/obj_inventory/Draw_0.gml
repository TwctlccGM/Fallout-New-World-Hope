/// @description
//draw_self();
//var _item_x = item_pos * 22;
//var _xx = obj_camera.x - 160;
//var _yy = obj_camera.y - 50;

draw_set_font(fnt_monofonto);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _items_xx = obj_camera.x;
var _party_xx = obj_camera.x - 160;
var _yy = obj_camera.y - 90;

// Draw the inventory
if (draw_inventory == true) 
{ 	
	/// Draw party info tab
	_yy = obj_camera.y - 90;
	
	draw_sprite_stretched(global.ui_textbox, 0, _party_xx, _yy, 160, 180);
	draw_set_font(fnt_fixedsys);
	draw_text(_party_xx + 5, _yy + 5, "PARTY");
	for(var _pos = 0; _pos < array_length(global.party); _pos++)
    {
		draw_sprite(global.party[_pos].sprites.inventory, 0, _party_xx + 35, _yy + 45);
		draw_text(_party_xx + 62, _yy + 28, "LVL: " + string(global.party[_pos].level));
		draw_text(_party_xx + 62, _yy + 43, "HP :" + string(global.party[_pos].hp) + "/" + string(global.party[_pos].hp_max));
		draw_healthbar(_party_xx + 98, _yy + 58, _party_xx + 148, _yy + 58, (global.party[_pos].hp / global.party[_pos].hp_max) * 100, c_gray, c_red, c_green, 0, true, false);
		_yy += 50;
	}
	
	if (party_selected == true)
	{
		/// Draw stats tab
		_yy = obj_camera.y - 90;
	
		draw_sprite_stretched(global.ui_textbox, 0, _items_xx, _yy, 160, 180);
		draw_set_font(fnt_fixedsys);
		draw_text(_items_xx + 5, _yy + 5, "STATS");
		draw_text(_items_xx + 70, _yy + 5, string(global.party[cursor.stored_target_index].name));
		// Special
		draw_text(_items_xx + 10, _yy + 35, "Points: " + string(global.party[cursor.stored_target_index].special_points));
			draw_text(_items_xx + 15, _yy + 55, "STR " + string(global.party[cursor.stored_target_index].strength));
			draw_text(_items_xx + 15, _yy + 70, "PER " + string(global.party[cursor.stored_target_index].perception));
			draw_text(_items_xx + 15, _yy + 85, "END " + string(global.party[cursor.stored_target_index].endurance));
			draw_text(_items_xx + 15, _yy + 100, "CHA " + string(global.party[cursor.stored_target_index].charisma));
			draw_text(_items_xx + 15, _yy + 115, "INT " + string(global.party[cursor.stored_target_index].intelligence));
			draw_text(_items_xx + 15, _yy + 130, "AGI " + string(global.party[cursor.stored_target_index].agility));
			draw_text(_items_xx + 15, _yy + 145, "LCK " + string(global.party[cursor.stored_target_index].luck));
		// Perks
		//draw_text(_items_xx + 75, _yy + 95, "Perk\npoints: " + string(global.party[cursor.stored_target_index].perk_points));
	}
	else
	{
		/// Draw inventory tab
		_yy = obj_camera.y - 90;
	
		draw_sprite_stretched(global.ui_textbox, 0, _items_xx, _yy, 160, 180);
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
	}
}

// Draw target cursor
if (cursor.active)
{
	with (cursor)
	{
		var _x_offset = 17;
		var _y_offset = 41;
		
		if (target_side = global.inventory_array)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_rectangle(_items_xx + 10, _yy + (target_index * 25) + 30, _items_xx + 52, _yy + (target_index * 25) + 50, true)
			draw_sprite(global.ui_pointer, 0, _items_xx + _x_offset, _yy + (target_index * 25) + _y_offset);
		}
		
		if (target_side = obj_inventory.party)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_rectangle(_party_xx + 10, _yy + (target_index * 50) + 25, _party_xx + 150, _yy + (target_index * 50) + 65, true)
			draw_sprite(global.ui_pointer, 0, _party_xx + _x_offset, _yy + (target_index * 50) + _y_offset);
		}
		
		if (target_side = party_member_stats)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_rectangle(_items_xx + 12, _yy + (target_index * 15) + 56, _items_xx + 65, _yy + (target_index * 15) + 70, true)
			draw_sprite(global.ui_pointer, 0, _items_xx + _x_offset, _yy + (target_index * 15) + _y_offset + 23);
			draw_sprite(global.ui_pointer, 0, _party_xx + _x_offset, _yy + (stored_target_index * 50) + _y_offset);
		}
		
		if (obj_inventory.stimpak_selected)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_sprite(global.ui_pointer, 0, _items_xx + _x_offset, _yy + (stored_target_index * 50) + _y_offset);
		}
		
		if (obj_inventory.doctorsbag_selected)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_sprite(global.ui_pointer, 0, _items_xx + _x_offset, _yy + (stored_target_index * 50) + _y_offset);
		}
	}
}



