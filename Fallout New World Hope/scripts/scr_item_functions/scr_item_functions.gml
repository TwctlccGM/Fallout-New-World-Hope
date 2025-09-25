// @desc Pickup Item - makes a menu, options provided in the form [["name", function, argument, boolean], [...]]
/*function pickup_item(_item_name, _item_sprite)
{
	var _pos = 0;
	var _inventory_size = array_length(global.item_array);

	while (_pos < _inventory_size) // Scan array for if the item type is already in there
	{
		if (global.item_array[_pos][C_ITEM_TYPE] == _item_name) { break; }
		else { _pos += 1; }
	}
	if (_pos < _inventory_size) // If item is present, increment the amount
	{
		global.item_array[_pos][C_ITEM_AMOUNT] += 1;	
		instance_destroy();
	}
	if (_pos >= _inventory_size) // If item is not present, add it to the array
	{
		var _new_item = array_create(3); // Create inner array
		_new_item[C_ITEM_TYPE] = _item_name;
		_new_item[C_ITEM_SPRITE] = _item_sprite;
		_new_item[C_ITEM_AMOUNT] = 1;
		array_push(global.item_array, _new_item);
		instance_destroy();
	}
}*/

function pickup_item(_item_name)
{
	global.item_array[item][C_ITEM_AMOUNT] += 1;
	instance_destroy();
}