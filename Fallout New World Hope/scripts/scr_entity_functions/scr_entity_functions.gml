function open_door(_key, _id) {
	// @arg key
	// @arg id
	
	if (global.item_array[_key][C_ITEM_AMOUNT] > 0)
	{
		global.item_array[_key][C_ITEM_AMOUNT] -= 1;
		instance_destroy(_id); // Door opens
	}
}