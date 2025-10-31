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

/// Use item function
function use_item(_item, _target)
{
	if (global.item_array[_item][C_ITEM_AMOUNT] > 0)
	{ 
		var _heal = 0;
		switch (_item) 
		{
			case (ITEM_STIMPAK):
				_heal = global.party[0].intelligence * 10; // Scales off Vaultie's INT
				battle_change_hp(global.party[_target], _heal, 2, 1, 0); // Heal target
				new_text_box("Vaultie used a " + string(global.item_array[ITEM_STIMPAK][C_ITEM_NAME]));
				break;
			case (ITEM_DOCTORSBAG):
				_heal = global.party[0].intelligence * 10; // Scales off Vaultie's INT
				battle_change_hp(global.party[_target], _heal, 2, 1, 1); // Heal target
				new_text_box("Vaultie used a " + string(global.item_array[ITEM_DOCTORSBAG][C_ITEM_NAME]));
				break;
			//case (ITEM_BATTLEBREW):
			//	_target.attack_value = _target.attack_value * 1.5;
			//	_target.armour_value = _target.armour_value + 5;
			//	break;
		}
		
		global.item_array[_item][C_ITEM_AMOUNT] -= 1; // Remove item
		// Find inventory index
		for(var _pos = 0; _pos < array_length(global.inventory_array); _pos++)
	    {
			if (global.inventory_array[_pos][C_ITEM_TYPE] == global.item_array[_item][C_ITEM_TYPE])
	        {
				global.inventory_array[_pos][C_ITEM_AMOUNT] -= 1; // Remove item
			}
		}
	}
}