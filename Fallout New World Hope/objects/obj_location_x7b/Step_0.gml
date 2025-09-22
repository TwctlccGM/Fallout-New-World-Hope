/// @description
if (place_meeting(x, y, obj_player_overworld))
{
	sprite_index = spr_overworld_location_2;
	if (keyboard_check(ord("Z"))) { room_goto(rm_field_test_x7b); };
	draw_set_color(c_white);
	draw_set_font(fnt_fixedsys);
	draw_text(x, y, "X-7B");
}
else
{
	sprite_index = spr_overworld_location;
}
