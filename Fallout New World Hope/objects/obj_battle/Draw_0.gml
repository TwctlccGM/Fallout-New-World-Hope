/// @description
draw_sprite(battle_background, 0, x, y);

// Draw units in depth order
var _unit_with_current_turn = unit_turn_order[turn].id;
for (var i = 0; i < array_length(unit_render_order); i ++)
{
	with (unit_render_order[i ])
	{
		draw_self();
	}
}

// Positions
// Old Macros
//#macro COLUMN_ENEMY 5
//#macro COLUMN_NAME 80
//#macro COLUMN_HP 170
//#macro COLUMN_AP 235
// New Macros
#macro COLUMN_NAME 5
#macro COLUMN_HP 130
#macro COLUMN_AP 210
#macro COLUMN_BET 270

// Draw headings
draw_set_font(fnt_fallout_6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);

// Draw UI boxes
draw_sprite_stretched(spr_textbox_ph, 0, x, y + 120, COLUMN_HP - 10, 60);
draw_sprite_stretched(spr_textbox_ph, 0, x + COLUMN_HP - 9, y + 120, COLUMN_BET - 71, 60);

//draw_text(x + COLUMN_ENEMY, y + 125, "ENEMY");
draw_text(x + COLUMN_NAME, y + 125, "NAME");
draw_text(x + COLUMN_HP, y + 125, "HP");
draw_text(x + COLUMN_AP, y + 125, "AP");
draw_text(x + COLUMN_BET, y + 125, "BET");

// Draw enemy names
draw_set_font(fnt_fixedsys);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
// TO-DO: Replace this system with one that can handle longer names/more enemies
/*var _draw_limit = 3;
var _drawn = 0;
for (var i = 0; (i < array_length(enemy_units)) && (_drawn < _draw_limit); i++)
{
	var _char = enemy_units[i ];
	if (_char.hp > 0)
	{
		_drawn++;
		draw_set_color(c_white);
		if (_char.id == _unit_with_current_turn) draw_set_color(c_yellow);
		draw_text(x + COLUMN_ENEMY, y + 135 + (i * 12), _char.name);
	}
}*/

// Draw party info
for (var i = 0; i < array_length(party_units); i++)
{
	draw_set_halign(fa_left);
	
	// Names
	draw_set_color(c_white);
	var _char = party_units[i];
	if (_char.id == _unit_with_current_turn) draw_set_color(c_yellow);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_NAME, y + 135 + (i * 12), _char.name);
	draw_set_halign(fa_right);
	// HP
	draw_set_color(c_white);
	if (_char.hp < (_char.hp_max * 0.5)) draw_set_color(c_orange);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_HP + 55, y + 135 + (i * 12), string(_char.hp) + "/" + string(_char.hp_max));
	// AP
	draw_set_color(c_white);
	if (_char.ap < (_char.ap_max * 0.5)) draw_set_color(c_orange);
	if (_char.ap <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_AP + 40, y + 135 + (i * 12), string(_char.ap) + "/" + string(_char.ap_max));
	// BET
	draw_set_color(c_white);
	//if (_char.ap < (_char.ap_max * 0.5)) draw_set_color(c_orange);
	//if (_char.ap <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_BET + 25, y + 135 + (i * 12), "100"); // TO-DO: Replace '100's with BET value when BET system is made
	draw_healthbar(x + COLUMN_BET + 2, y + 149 + (i * 12), x + COLUMN_BET + 25, y + 149  + (i * 12), _char.bet, c_gray, c_gray, c_blue, 0, true, false);
	
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
				draw_sprite(spr_pointer_ph, 0, active_target.x - 5, active_target.y);
			}
			else
			{
				draw_set_alpha(sin(get_timer()/50000)+1); // Multi-target and cursor flash
				for (var i = 0; i < array_length(active_target); i ++)
				{
					draw_sprite(spr_pointer_ph, 0, active_target[i].x - 5, active_target[i].y);
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