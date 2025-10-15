/// @description
#macro PLAYER_STATE_ACTIVE 0
#macro PLAYER_STATE_LOCKED 1

state = PLAYER_STATE_ACTIVE;
last_state = state;
delay = 1;

speed_walk = 2;

collision_map = layer_tilemap_get_id(layer_get_id("Collision"));

/*
move_x = 0;				// Movement (horizontal)
move_y = 0;				// Movement (vertical)
move_speed = 2;			// Player speed

direction = 0;			// Direction (0 = right, 90 = up, 180 = left, 270 = down)
image_xscale = 1;		// Left/Right
*/



