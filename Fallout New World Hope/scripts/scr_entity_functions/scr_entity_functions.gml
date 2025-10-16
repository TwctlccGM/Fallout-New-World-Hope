function open_door(_key) {
	// @arg key
	
	if (global.item_array[_key][C_ITEM_AMOUNT] > 0)
	{
		global.item_array[_key][C_ITEM_AMOUNT] -= 1;
		instance_destroy(); // Door opens
	}
}

function pickup_item(_item, _quantity) {
	// @arg item
	// @arg quantity

	global.item_array[_item][C_ITEM_AMOUNT] += _quantity;
	instance_destroy(); // Item goes into inventory
}