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
	if (draw_inventory == true) 
	{ 
		draw_inventory = false; 
		cursor.active =  false;
		global.pause = false; 
	}
	else if (draw_inventory == false) 
	{ 
		draw_inventory = true; 
		cursor.active =  true;
		global.pause = true; 
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
	for(var _pos = 0; _pos < 5; _pos++)
    {
		if !(global.item_array[_pos, C_ITEM_TYPE] == ITEM_NONE)
        {
			draw_sprite(global.item_array[_pos, C_ITEM_SPRITE], 0, _items_xx + 20, _yy + 40);
			draw_text(_items_xx + 35, _yy + 30, string(global.item_array[_pos, C_ITEM_AMOUNT]));
        }
		_yy += 25;
	}
	
	/// Draw party info tab
	_yy = obj_camera.y - 90;
	
	draw_sprite_stretched(spr_textbox_ph, 0, _party_xx, _yy, 160, 180);
	draw_set_font(fnt_fixedsys);
	draw_text(_party_xx + 5, _yy + 5, "PARTY");
	for(var _pos = 0; _pos < array_length(global.party); _pos++)
    {
		draw_sprite(global.party[_pos].sprites.idle, 0, _party_xx + 30, _yy + 45);
		draw_text(_party_xx + 50, _yy + 30, "HP: " + string(global.party[_pos].hp) + "/" + string(global.party[_pos].hp_max));
		draw_healthbar(_party_xx + 80, _yy + 45, _party_xx + 140, _yy + 46, global.party[_pos].hp, c_gray, c_red, c_green, 0, true, false);
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
				_yy = obj_camera.y - 90;
				draw_sprite(spr_pointer_ph, 0, _items_xx, _yy + (target_index * 25) + 25);
			//}
		//}
	}
}



