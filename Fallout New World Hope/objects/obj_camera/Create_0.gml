/// @description Setup camera

cam = view_camera[0]; // Assign camera to viewport 0

if (room == rm_overworld) { // Overworld camera
	x = obj_player_overworld.x;	// Set cam coords to player coords
	y = obj_player_overworld.y;
	follow = obj_player_overworld;  // Set 'follow' to player object (used in Step event)
}

else { // Field camera
	x = obj_player_field.x;	// Set cam coords to player coords
	y = obj_player_field.y;
	follow = obj_player_field;  // Set 'follow' to player object (used in Step event)
}

view_width_half = camera_get_view_width(cam) * 0.5;	  // Half of the screen width
view_height_half = camera_get_view_height(cam) * 0.5; // Half of the screen height
x_to = xstart; // Initialise x_to (for use in camera movement)
y_to = ystart; // Initialise y_to (for use in camera movement)






