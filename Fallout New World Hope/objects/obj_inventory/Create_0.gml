/// @description
draw_set_font(fnt_monofonto);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

item_pos = 0;
item_pos_index = 0;

stimpak_selected = false;
doctorsbag_selected = false;
draw_inventory = false;

// Make targeting cursor
cursor = 
{
	active_user: noone,
	active_target: noone,
	active_action: -1,
	target_side: -1,
	target_index: 0,
	stored_target_index: 0,
	target_all: false,
	confirm_delay: 0,
	active: false
};