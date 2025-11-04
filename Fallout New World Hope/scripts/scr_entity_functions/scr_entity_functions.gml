function open_door(_key) {
	// @arg key
	if (global.item_array[_key][C_ITEM_AMOUNT] > 0)
	{
		global.item_array[_key][C_ITEM_AMOUNT] -= 1;
		new_text_box("Opened door with a " + string(global.item_array[_key][C_ITEM_NAME]), FIELD);
		instance_destroy(); // Door opens
	}
	else
	{
		new_text_box("This doors requires a Keycard");	
	}
}

function pickup_item(_item, _quantity) {
	// @arg item
	// @arg quantity

	global.item_array[_item][C_ITEM_AMOUNT] += _quantity;
	new_text_box("Looted a " + string(global.item_array[_item][C_ITEM_NAME]), FIELD);
	instance_destroy(); // Item goes into inventory
}