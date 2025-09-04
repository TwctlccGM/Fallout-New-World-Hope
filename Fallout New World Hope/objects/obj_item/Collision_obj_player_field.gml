/// @description
if (keyboard_check(ord("Z")))
{
	var _pos = 0;
	var _type = item;
	var _sprite = sprite_index;

	with(obj_inventory)
    {
		while (_pos < 5) // Scan array for if the item type is already in there
		{
			if (item_array[_pos][C_ITEM_TYPE] == _type) { break; }
			else { _pos += 1; }
		}
		if (_pos > 4)
        {
			_pos = 0;
			while (_pos < 5)
            {
				if (item_array[_pos][C_ITEM_TYPE] == ITEM_NONE) { break; }
				else { _pos += 1; }
            }
        }
		if (_pos < 5)
		{
			item_array[_pos][C_ITEM_TYPE] = _type;
			item_array[_pos][C_ITEM_SPRITE] = _sprite;
			item_array[_pos][C_ITEM_AMOUNT] += 1;
			with(other) instance_destroy();
		}
    }
}





