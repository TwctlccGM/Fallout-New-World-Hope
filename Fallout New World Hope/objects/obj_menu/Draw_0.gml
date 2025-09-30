/// @description
// Macros
#macro OPTIONS_COLUMN 19
#macro OPTIONS_ROW 111

draw_set_color(c_white);
draw_set_font(fnt_fallout_6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw menu box
draw_sprite_stretched(spr_textbox_ph, 0, x + OPTIONS_COLUMN - 6, y + OPTIONS_ROW, 95, 56);

var _desc = (description != -1);
var _scroll_push = max(0, hover - (visible_options_max - 1));

/// Array system
for (var i = 0; i < (visible_options_max + _desc); i++)
{
	if (i >= array_length(options)) break;
	draw_set_color(c_white);
	if (i == 0) && (_desc)
	{
		draw_text(x + OPTIONS_COLUMN + x_margin, y + OPTIONS_ROW + y_margin, description)
	}
	else
	{
		var _option_to_show = i - _desc + _scroll_push;
		var _str = options[_option_to_show][0];
		if (hover == _option_to_show - _desc)
		{
			draw_set_color(c_yellow);
		}
		if (options[_option_to_show][3] == false) draw_set_color(c_gray);
		draw_text(x + OPTIONS_COLUMN + x_margin, y + OPTIONS_ROW + y_margin - 2 + i * height_line, _str);
	}
}

draw_sprite(spr_pointer_ph, 0, x + OPTIONS_COLUMN + 11, y + OPTIONS_ROW + 10 + ((hover - _scroll_push) * height_line));
if (visible_options_max < array_length(options)) && (hover < array_length(options) - 1)
{
	draw_sprite(spr_downarrow_ph, 0, x + OPTIONS_COLUMN + 75, y + OPTIONS_ROW + 45);
}