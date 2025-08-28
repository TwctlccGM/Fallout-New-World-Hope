/// @description
draw_sprite(battle_background, 0, x, y);

// Draw units in depth order
var _unit_with_current_turn = unit_turn_order[turn].id;
for (var _i = 0; _i < array_length(unit_render_order); _i++)
{
	with (unit_render_order[_i])
	{
		draw_self();
	}
}

// Draw UI boxes
// TO-DO: Replace magic numbers
draw_sprite_stretched(spr_textbox_ph, 0, x + 75, y + 120, 245, 60);
draw_sprite_stretched(spr_textbox_ph, 0, x, y + 120, 74, 60);

// Positions
// TO-DO: Replace this magic number system
#macro COLUMN_ENEMY 5
#macro COLUMN_NAME 80
#macro COLUMN_HP 170
#macro COLUMN_AP 235

// Draw headings
draw_set_font(fnt_fallout_6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
draw_text(x + COLUMN_ENEMY, y + 125, "ENEMY");
draw_text(x + COLUMN_NAME, y + 125, "NAME");
draw_text(x + COLUMN_HP, y + 125, "HP");
draw_text(x + COLUMN_AP, y + 125, "AP");

// Draw enemy names
draw_set_font(fnt_fixedsys);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
// TO-DO: Replace this system with one that can handle longer names/more enemies
var _draw_limit = 3;
var _drawn = 0;
for (var _i = 0; (_i < array_length(enemy_units)) && (_drawn < _draw_limit); _i++)
{
	var _char = enemy_units[_i];
	if (_char.hp > 0)
	{
		_drawn++;
		draw_set_color(c_white);
		if (_char.id == _unit_with_current_turn) draw_set_color(c_yellow);
		draw_text(x + COLUMN_ENEMY, y + 135 + (_i * 12), _char.name);
	}
}

// Draw party info
for (var _i = 0; _i < array_length(party_units); _i++)
{
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	var _char = party_units[_i];
	if (_char.id == _unit_with_current_turn) draw_set_color(c_yellow);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_NAME, y + 135 + (_i * 12), _char.name);
	draw_set_halign(fa_right);
	
	draw_set_color(c_white);
	if (_char.hp < (_char.hp_max * 0.5)) draw_set_color(c_orange);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_HP + 55, y + 135 + (_i *12), string(_char.hp) + "/" + string(_char.hp_max));
	
	draw_set_color(c_white);
	if (_char.ap < (_char.ap_max * 0.5)) draw_set_color(c_orange);
	if (_char.ap <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_AP + 40, y + 135 + (_i *12), string(_char.ap) + "/" + string(_char.ap_max));
	
	draw_set_color(c_white);
}

// Draw target cursor
if (cursor.active)
{
	with (cursor)
	{
		if (active_target != noone)
		{
			if (!is_array(active_target)) // Single target
			{
				draw_sprite(spr_pointer_ph, 0, active_target.x - 15, active_target.y - 15);
			}
			else
			{
				draw_set_alpha(sin(get_timer()/50000)+1); // Multi-target and cursor flash
				for (var _i = 0; _i < array_length(active_target); _i++)
				{
					draw_sprite(spr_pointer_ph, 0, active_target[_i].x - 15, active_target[_i].y - 15);
				}
				draw_set_alpha(1.0);
			}
		}
	}
}

// Draw battle text
if (battle_text != "")
{
	var _w = string_width(battle_text) + 20;
	draw_sprite_stretched(spr_textbox_ph, 0, x + 160 - (_w * 0.5), y + 5, _w, 25);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(x + 160, y + 10, battle_text);
}