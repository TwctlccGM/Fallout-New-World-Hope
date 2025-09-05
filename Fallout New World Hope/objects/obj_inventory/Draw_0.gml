/// @description
//draw_self();
var _item_x = item_pos * 22;
var _xx = obj_camera.x - 160;
var _yy = obj_camera.y - 50;

draw_set_font(fnt_monofonto);

if (keyboard_check_pressed(vk_tab)) // Toggle inventory
{
	if (draw_inventory == true) { draw_inventory = false; global.pause = false; }
	else if (draw_inventory == false) { draw_inventory = true; global.pause = true; }
}

// Draw the inventory
if (draw_inventory == true) 
{ 
	//draw_sprite_stretched(spr_textbox_ph, 0, obj_camera.x - 85, obj_camera.y + 30, 245, 60);
	draw_sprite_stretched(spr_textbox_ph, 0, _xx, _yy, 50, 100);
	draw_sprite(spr_pointer_ph, 0, _xx, _yy);
	//item_pos_index += 0.2;
	for(var _i = 0; _i < 5; _i++)
    {
		if !(global.item_array[_i, C_ITEM_TYPE] == ITEM_NONE)
        {
			draw_sprite(global.item_array[_i, C_ITEM_SPRITE], 0, _xx + 25, _yy + 15);
			draw_text(_xx + 45, _yy  + 25, string(global.item_array[_i, C_ITEM_AMOUNT]));
        }
		_yy += 22;
	}
}




