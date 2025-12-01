/// @description
#macro NEW_GAME 0
#macro LOAD_GAME 1
#macro OPTIONS 2
#macro QUIT 3

depth = -9999999;

item_pos = 0;
item_pos_index = 0;

title_menu_options = 
[
	"New Game",
	"Load Game",
	"Options",
	"Quit"
];

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
	active: true,
	flag_for_target_index_stuff: false
};















