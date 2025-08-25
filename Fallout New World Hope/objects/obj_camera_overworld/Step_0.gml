/// @description Update camera

// Update destination
if (instance_exists(follow))
{
	x_to = follow.x; // Go to 'follow' (player) x co-ordinate.
	y_to = follow.y; // Go to 'follow' (player) y co-ordinate.
}

// Camera smoothing (Bigger division number = Slower camera movement)
x += (x_to - x) / 25; 
y += (y_to - y) / 25;

// Clamping (so camera doesn't go past room borders)
x = clamp(x, view_width_half, room_width - view_width_half);
y = clamp(y, view_height_half, room_height - view_height_half);

// Update camera view
camera_set_view_pos(cam, x - view_width_half, y - view_height_half);






