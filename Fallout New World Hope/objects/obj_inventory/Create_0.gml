/// @description
draw_set_font(fnt_monofonto);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

item_pos = 0;
item_pos_index = 0;
item_array = array_create(5); // Create inventory array of arrays

for(var _i = 0; _i < 5; _i ++) // Initialise item type, sprite, and amount for each array
{
	item_array[_i][C_ITEM_TYPE] = ITEM_NONE;
	item_array[_i][C_ITEM_SPRITE] = -1;
	item_array[_i][C_ITEM_AMOUNT] = 0;
}

draw_inventory = false;



