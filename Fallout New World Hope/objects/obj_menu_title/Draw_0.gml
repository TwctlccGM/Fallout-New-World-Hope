/// @description
draw_set_font(fnt_fixedsys);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _xx = x + 210;
var _yy = y;

// Draw menu tab
draw_sprite_stretched(global.ui_textbox, 0, _xx, _yy, 110, 180);
//draw_set_font(fnt_monofonto);
draw_text(_xx + 18, _yy + 20, "Fallout:\nFan Game");
draw_set_font(fnt_fixedsys);

// Title menu
if (title_menu_selected)
{
	for(var _pos = 0; _pos < array_length(title_menu_options); _pos++)
	{
		draw_text(_xx + 18, _yy + 80, title_menu_options[_pos]);
		_yy += 25;
	}
}

// Options menu
if (options_menu_selected)
{
	for(var _pos = 0; _pos < array_length(options_menu_options); _pos++)
	{
		draw_text(_xx + 18, _yy + 80, options_menu_options[_pos]);
		_yy += 25;
	}
}

// Colour menu
if (colour_menu_selected)
{
	for(var _pos = 0; _pos < array_length(colour_menu_options); _pos++)
	{
		draw_text(_xx + 18, _yy + 80, colour_menu_options[_pos]);
		_yy += 25;
	}
}

// Draw target cursor
if (cursor.active)
{
	with (cursor)
	{
		_yy = obj_menu_title.y;
		if (obj_menu_title.title_menu_selected)
		{
			var _w = string_width(obj_menu_title.title_menu_options[target_index]);	// Get width of string to stretch rectangle
		}
		else if (obj_menu_title.options_menu_selected)
		{
			var _w = string_width(obj_menu_title.options_menu_options[target_index]);	// Get width of string to stretch rectangle	
		}
		else if (obj_menu_title.colour_menu_selected)
		{
			var _w = string_width(obj_menu_title.colour_menu_options[target_index]);	// Get width of string to stretch rectangle	
		}
		draw_set_color(c_white)
		draw_rectangle(_xx + 15, _yy + (target_index * 25) + 81, _xx + 21 + _w, _yy + (target_index * 25) + 97, true)
		draw_sprite(global.ui_pointer, 0, _xx + 17, _yy + (target_index * 25) + 90);
	}
}













