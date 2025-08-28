/// @description

move_x = keyboard_check(vk_right) - keyboard_check(vk_left); // Move left/right
move_x *= move_speed; // Move horizontally based on move_speed

move_y = keyboard_check(vk_down) - keyboard_check(vk_up); // Move up/down
move_y *= move_speed; // Move vertically based on move_speed

move_and_collide(move_x, move_y, obj_collision_box, 16, 0, 0, move_speed, move_speed);

