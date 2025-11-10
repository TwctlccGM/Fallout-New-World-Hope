/// @description
if (place_meeting(x, y, obj_player_overworld))
{
	sprite_index = spr_overworld_location_2;
	if (keyboard_check(ord("Z"))) { room_goto(rm_field_y17); };
}
else
{
	sprite_index = spr_overworld_location;
}