/// @description
// Macros
#macro OPTIONS_COLUMN 19
#macro OPTIONS_ROW 111

draw_set_color(c_white);
draw_set_font(fnt_fallout_6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw menu box
draw_sprite_stretched(global.ui_textbox, 0, x + OPTIONS_COLUMN, y + OPTIONS_ROW, 102, 56);

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

// Draw pointer and optional up/down/left/right arrows
draw_sprite(global.ui_pointer, 0, x + OPTIONS_COLUMN + 11, y + OPTIONS_ROW + 10 + ((hover - _scroll_push) * height_line));

if (3 < array_length(options)) && (hover >= visible_options_max)
{
	draw_sprite(global.ui_arrow_up, 0, x + OPTIONS_COLUMN + 45, y + OPTIONS_ROW + 43);
}
if (visible_options_max < array_length(options)) && (hover < array_length(options) - 1)
{
	draw_sprite(global.ui_arrow_down, 0, x + OPTIONS_COLUMN + 45, y + OPTIONS_ROW + 47);
}
if (sub_menu_level > 0)
{
	draw_sprite(global.ui_arrow_left, 0, x + OPTIONS_COLUMN + 6, y + OPTIONS_ROW + 44);	
}
if (sub_menu_level <= 0 && (hover != 0))
{
	draw_sprite(global.ui_arrow_right, 0, x + OPTIONS_COLUMN + 93, y + OPTIONS_ROW + 44);	
}