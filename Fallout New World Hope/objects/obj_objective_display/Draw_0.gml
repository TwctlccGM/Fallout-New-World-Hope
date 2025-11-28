/// @description
draw_set_font(fnt_fixedsys);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _xx = obj_camera.x - 160;
var _yy = obj_camera.y - 90;

// Draw the objective display
if (show_objective == true) 
{ 	
	var _pad = 4;
	var _w = string_width(current_objective) + _pad * 2;	// Get width of string to stretch textbox
	draw_sprite_stretched(global.ui_textbox, 0, _xx, _yy, _w, 22);
	draw_text(_xx + _pad, _yy + 2, current_objective);
}














