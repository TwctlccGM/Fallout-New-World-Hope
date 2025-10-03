/// @description
if (global.pause) exit;

if (place_meeting(x, y, obj_player_field)) 
{
	if keyboard_check(ord("Z")) 
	{
		array_insert(global.party, array_length(global.party), global.party_data[PARTY_CYBERDOG]);
		instance_destroy();
	}
}





