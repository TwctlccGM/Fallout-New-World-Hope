/// @description
depth = -9999999;

item_pos = 0;
item_pos_index = 0;

title_menu_selected = true;
options_menu_selected = false;
colour_menu_selected = false;

title_menu_options = 
[
	"New Game",
	"Load Game",
	"Options",
	"Quit"
];

#macro NEW_GAME 0
#macro LOAD_GAME 1
#macro OPTIONS 2
#macro QUIT 3

options_menu_options = 
[
	"UI Colour",
	"Back"
];

#macro UI_COLOUR 0
#macro BACK1 1


colour_menu_options = 
[
	"Orange",
	"Blue",
	"Green",
	"Back"
];

#macro ORANGE 0
#macro BLUE 1
#macro GREEN 2
#macro BACK2 3


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
