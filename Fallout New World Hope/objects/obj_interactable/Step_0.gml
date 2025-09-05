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
				instance_destroy(self); // Door opens
			}
		}
	}
}





