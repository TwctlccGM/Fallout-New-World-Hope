/// @description

/// Player movement towards destination
// Mouse controls
if (instance_exists(obj_player_destination))
{
	var dir = point_direction(x, y, obj_player_destination.x, obj_player_destination.y)
	if !place_meeting(x + lengthdir_x(move_speed, dir), y + lengthdir_y(move_speed, dir), obj_collision_box)
	{
		x += lengthdir_x(move_speed, dir)
		y += lengthdir_y(move_speed, dir)
	}
	else
	{
		// Collision handling
		while(!place_meeting(x + lengthdir_x(1, dir), y + lengthdir_y(1, dir), obj_collision_box))
		{
			x += lengthdir_x(1, dir)
			y += lengthdir_y(1, dir)
		}
		instance_destroy(obj_player_destination);
	}
}
// Key controls
else
{
	move_x = keyboard_check(vk_right) - keyboard_check(vk_left); // Move left/right
	move_x *= move_speed; // Move horizontally based on move_speed

	move_y = keyboard_check(vk_down) - keyboard_check(vk_up); // Move up/down
	move_y *= move_speed; // Move vertically based on move_speed

	move_and_collide(move_x, move_y, obj_collision_box, 16, 0, 0, move_speed, move_speed);	
}

// Create new player destination
if (mouse_check_button_pressed(mb_left))
{
	instance_destroy(obj_player_destination);
	instance_create_depth(mouse_x, mouse_y, -10, obj_player_destination);	
}