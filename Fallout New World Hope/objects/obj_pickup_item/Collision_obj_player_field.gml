/// @description
if (global.pause) exit;

if (keyboard_check(ord("Z")))
{
	//pickup_item(item);
	global.item_array[item][C_ITEM_AMOUNT] += 1;
	instance_destroy();
}

		//global.item_array[_pos][C_ITEM_TYPE] = _type;
		//global.item_array[_pos][C_ITEM_SPRITE] = _sprite;
		//global.item_array[_pos][C_ITEM_AMOUNT] = 1;



