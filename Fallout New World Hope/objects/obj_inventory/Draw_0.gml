/// @description
//draw_self();
var _item_x = item_pos * 22;
var _xx = bbox_left + 13 ;
var _yy = bbox_top + 13;

if (keyboard_check_pressed(vk_tab)) // Toggle inventory
{
	if (draw_inventory == true) { draw_inventory = false; }
	else if (draw_inventory == false) { draw_inventory = true; }
}

// Draw the inventory
if (draw_inventory == true) 
{ 
	draw_sprite_stretched(spr_textbox_ph, 0, x, y, 60, 60); 
	draw_sprite(spr_pointer_ph, 0, _xx + _item_x, _yy);
	//item_pos_index += 0.2;
	for(var _i = 0; _i < 5; _i += 1)
    {
		if !(item_array[_i, C_ITEM_TYPE] == ITEM_NONE)
        {
			draw_sprite(item_array[_i, C_ITEM_SPRITE], 0, _xx, _yy);
			draw_text(_xx + 8, _yy + 9,  + string(item_array[_i, C_ITEM_AMOUNT]));
        }
		_xx += 22;
	}
}




