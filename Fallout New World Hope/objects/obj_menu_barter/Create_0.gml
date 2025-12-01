/// @description
#macro BARTER_STATE_ACTIVE 3
#macro BARTER_STATE_LOCKED 4

state = BARTER_STATE_ACTIVE;
last_state = state;

depth = -9999999;

item_pos = 0;
item_pos_index = 0;

draw_barter = false;

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
	active: false,
	flag_for_target_index_stuff: false
};















