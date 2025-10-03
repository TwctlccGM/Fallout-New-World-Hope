/// @description
if (global.pause) exit;

if (place_meeting(x, y, obj_player_field)) 
{
	if keyboard_check(ord("Z")) 
	{
		with (obj_door) 
		{
			if (door == other.interactable)
			{
				if (global.item_array[ITEM_KEYCARD][C_ITEM_AMOUNT] > 0)
				{
					global.item_array[ITEM_KEYCARD][C_ITEM_AMOUNT] -= 1;
					instance_destroy(self); // Door opens
				}
				// No key, door doesn't open
			}
		}
	}
}





