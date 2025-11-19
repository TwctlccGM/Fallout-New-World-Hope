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
	
	if (stats_selected == true)
	{
		/// Draw stats tab
		_yy = obj_camera.y - 90;
	
		draw_sprite_stretched(global.ui_textbox, 0, _items_xx, _yy, 160, 180);
		draw_set_font(fnt_fixedsys);
		draw_text(_items_xx + 5, _yy + 5, "STATS");
		draw_text(_items_xx + 70, _yy + 5, string(global.party[cursor.stored_target_index].name));
		// Special
		_yy = obj_camera.y - 90;
		draw_text(_items_xx + 80, _yy + 65, "SPECIAL\nPoints:\n   " + string(global.party[cursor.stored_target_index].special_points));
		switch (cursor.target_index)
			{
				case 0: draw_text(_items_xx + 10, _yy + 25, "Strength affects\nphysical damage.");	break;
				case 1: draw_text(_items_xx + 10, _yy + 25, "Perception affects\nranged damage.");	break;
				case 2: draw_text(_items_xx + 10, _yy + 25, "Endurance affects\nmax health.");		break;
				case 3: draw_text(_items_xx + 10, _yy + 25, "Charisma affects\nbarter costs.");	break;
				case 4: draw_text(_items_xx + 10, _yy + 25, "Intelligence\naffects items.");		break;
				case 5: draw_text(_items_xx + 10, _yy + 25, "Agility affects\nturn order.");		break;
				case 6: draw_text(_items_xx + 10, _yy + 25, "Luck affects\ncrit rate.");			break;
				default:
			}
			draw_text(_items_xx + 15, _yy + 65, "STR " + string(global.party[cursor.stored_target_index].strength));
			draw_text(_items_xx + 15, _yy + 80, "PER " + string(global.party[cursor.stored_target_index].perception));
			draw_text(_items_xx + 15, _yy + 95, "END " + string(global.party[cursor.stored_target_index].endurance));
			draw_text(_items_xx + 15, _yy + 110, "CHA " + string(global.party[cursor.stored_target_index].charisma));
			draw_text(_items_xx + 15, _yy + 125, "INT " + string(global.party[cursor.stored_target_index].intelligence));
			draw_text(_items_xx + 15, _yy + 140, "AGI " + string(global.party[cursor.stored_target_index].agility));
			draw_text(_items_xx + 15, _yy + 155, "LCK " + string(global.party[cursor.stored_target_index].luck));
		// Perks
		//draw_text(_items_xx + 75, _yy + 95, "Perk\npoints: " + string(global.party[cursor.stored_target_index].perk_points));
	}
	
	else if (swap_selected == true)
	{
		/// Draw party info tab
		_yy = obj_camera.y - 90;
	
		draw_sprite_stretched(global.ui_textbox, 0, _items_xx, _yy, 160, 180);
		draw_set_font(fnt_fixedsys);
		draw_text(_items_xx + 5, _yy + 5, "SWAP");
		for(var _pos = 0; _pos < array_length(cursor.party_member_waiting); _pos++)
	    {
			draw_sprite(cursor.party_member_waiting[_pos].sprites.inventory, 0, _items_xx + 35, _yy + 45);
			draw_text(_items_xx + 62, _yy + 28, "LVL: " + string(cursor.party_member_waiting[_pos].level));
			draw_text(_items_xx + 62, _yy + 43, "HP :" + string(cursor.party_member_waiting[_pos].hp) + "/" + string(cursor.party_member_waiting[_pos].hp_max));
			draw_healthbar(_items_xx + 98, _yy + 58, _items_xx + 148, _yy + 58, (cursor.party_member_waiting[_pos].hp / cursor.party_member_waiting[_pos].hp_max) * 100, c_gray, c_red, c_green, 0, true, false);
			_yy += 50;
		}
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
	if (party_selected == true)
	{
		/// Draw options tab
		_yy = obj_camera.y - 90;
	
		draw_sprite_stretched(global.ui_textbox, 0, _party_xx + 35, _yy + (cursor.stored_target_index * 50) + 37, 50, 40);
		draw_set_font(fnt_fixedsys);
		draw_text(_party_xx + 40, _yy + (cursor.stored_target_index * 50) + 40, "Stats");
		draw_text(_party_xx + 40, _yy + (cursor.stored_target_index * 50) + 55, "Swap");
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
			_yy = obj_camera.y - 80;
			draw_set_color(c_white)
			draw_rectangle(_items_xx + 12, _yy + (target_index * 15) + 56, _items_xx + 65, _yy + (target_index * 15) + 70, true)
			draw_sprite(global.ui_pointer, 0, _items_xx + _x_offset, _yy + (target_index * 15) + _y_offset + 23);
			draw_sprite(global.ui_pointer, 0, _party_xx + _x_offset, _yy + (stored_target_index * 50) + _y_offset);
		}
		
		if (target_side = party_member_options)
		{
			if (target_index >= 2) { target_index = 0; }
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_rectangle(_party_xx + 39, _yy + (stored_target_index * 50) + (target_index * 15) + 42, _party_xx + 80, _yy + (stored_target_index * 50) + (target_index * 15) + 55, true)
			draw_sprite(global.ui_pointer, 0, _party_xx + 40, _yy + (stored_target_index * 50) + (target_index * 15) + 50);
			draw_sprite(global.ui_pointer, 0, _party_xx + _x_offset, _yy + (stored_target_index * 50) + _y_offset);
		}
		
		if (target_side = party_member_waiting)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_rectangle(_items_xx + 10, _yy + (target_index * 50) + 25, _items_xx + 150, _yy + (target_index * 50) + 65, true)
			draw_sprite(global.ui_pointer, 0, _items_xx + _x_offset, _yy + (target_index * 50) + _y_offset);
		}
		
		if (obj_inventory.stimpak_selected)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_sprite(global.ui_pointer, 0, _items_xx + _x_offset, _yy + (stored_target_index * 25) + _y_offset);
		}
		
		if (obj_inventory.doctorsbag_selected)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_sprite(global.ui_pointer, 0, _items_xx + _x_offset, _yy + (stored_target_index * 25) + _y_offset);
		}
	}
}



