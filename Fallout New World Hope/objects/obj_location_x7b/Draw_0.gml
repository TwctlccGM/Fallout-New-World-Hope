/// @description
draw_self();
draw_set_font(fnt_fixedsys);
draw_set_color(c_black);
draw_text(x - 14, y - 19, "X-7b");	// Shadow
draw_set_color(c_white);
draw_text(x - 15, y - 20, "X-7b");	// Text

if (place_meeting(x, y, obj_player_overworld))
{
	draw_sprite_stretched(spr_textbox_ph, 0, x - 40, y + 15, 80, 30);
	draw_text(x - 35, y + 20, "Press 'Z'");	// Text
}