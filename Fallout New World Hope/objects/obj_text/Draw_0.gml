/// @description
draw_set_font(fnt_fixedsys);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

/*
draw_sprite_stretched(global.ui_textbox, background, x1, y1, x2, y2);
var _print = string_copy(text_message, 1, text_progress);
draw_text((x1 + x2) / 2, y1 + 8, _print)
*/

// TO-DO: Change textbox size and positioning based on if it's a dialogue, inventory pop-up, or field pop-up
var _xx = obj_camera.x - 160;
var _yy = obj_camera.y;
draw_sprite_stretched(global.ui_textbox, background, _xx, _yy, 320, 90); 
var _print = string_copy(text_message, 1, text_progress);

if (responses[0] != -1) && (text_progress >= string_length(text_message))
{
	for (var i = 0; i < array_length(responses); i++)
	{
		_print += "\n";	
		if (i == response_selected) _print += "> ";
		_print += responses[i];
	}
}

draw_text(_xx + 10, _yy + 5, _print);









