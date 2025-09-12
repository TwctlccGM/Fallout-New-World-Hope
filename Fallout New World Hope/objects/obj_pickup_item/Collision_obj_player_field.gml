/// @description
if (global.pause) exit;

if (keyboard_check(ord("Z")))
{
	var _pos = 0;
	var _inventory_size = array_length(global.item_array);
	var _type = item;
	var _sprite = sprite;

	while (_pos < _inventory_size) // Scan array for if the item type is already in there
	{
		if (global.item_array[_pos][C_ITEM_TYPE] == _type) { break; }
		else { _pos += 1; }
	}
	if (_pos < _inventory_size) // If item is present, increment the amount
	{
		global.item_array[_pos][C_ITEM_AMOUNT] += 1;	
		instance_destroy();
	}
	if (_pos >= _inventory_size) // If item is not present, add it to the array
	{
		global.item_array[_pos][C_ITEM_TYPE] = _type;
		global.item_array[_pos][C_ITEM_SPRITE] = _sprite;
		global.item_array[_pos][C_ITEM_AMOUNT] = 1;
		instance_destroy();
	}
}





