/// @description
if (global.pause) exit;
if (state == PLAYER_STATE_LOCKED) exit;

move_x = keyboard_check(vk_right) - keyboard_check(vk_left);	// Move left/right
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

delay--;