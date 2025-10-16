/// @description
delay--;
depth = -bbox_bottom;
if (global.pause) exit;
if (state == PLAYER_STATE_LOCKED) exit;

key_left		=	keyboard_check(vk_left);
key_right		=	keyboard_check(vk_right);
key_up			=	keyboard_check(vk_up);
key_down		=	keyboard_check(vk_down);
key_activate	=	keyboard_check_pressed(ord("Z"));

input_direction = point_direction(0, 0, key_right - key_left, key_down - key_up);
input_magnitude = (key_right - key_left != 0) || (key_down - key_up != 0);

// Movement
x_speed = lengthdir_x(input_magnitude * speed_walk, input_direction);
y_speed = lengthdir_y(input_magnitude * speed_walk, input_direction);

player_collision();

// Sprite
var _old_sprite = sprite_index;
if (input_magnitude != 0)
{
	direction = input_direction;

	if (direction == 0)			// Moving right
	{ 
		sprite_index = spr_vaultie_field_right;
	}
	else if (direction == 180)	// Moving left
	{ 
		sprite_index = spr_vaultie_field_left;
	}

	if (direction == 270)		// Moving down
	{ 
		sprite_index = spr_vaultie_field_front;
	}
	else if (direction == 90)	// Moving up
	{ 
		sprite_index = spr_vaultie_field_back;
	}
}



/// OLD MOVEMENT (AND DIRECTION) CODE
/*move_x = keyboard_check(vk_right) - keyboard_check(vk_left);	// Move left/right
move_x *= move_speed;											// Move horizontally based on move_speed

move_y = keyboard_check(vk_down) - keyboard_check(vk_up);		// Move up/down
move_y *= move_speed;											// Move vertically based on move_speed

if (move_x > 0)			// Moving right
{ 
	direction = 0;
	sprite_index = spr_vaultie_field_right;
}
else if (move_x < 0)	// Moving left
{ 
	direction = 180;
	sprite_index = spr_vaultie_field_left;
}

if (move_y > 0)			// Moving down
{ 
	direction = 270;
	sprite_index = spr_vaultie_field_front;
}
else if (move_y < 0)	// Moving up
{ 
	direction = 90;
	sprite_index = spr_vaultie_field_back;
}

move_and_collide(move_x, move_y, par_entity, 16, 0, 0, move_speed, move_speed);
*/

