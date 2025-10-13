/// @description
// Created as part of ARPG Tutorial Part 7
x1 = RESOLUTION_W / 2 + 200;
y1 = RESOLUTION_H / 2;
x2 = RESOLUTION_W / 2 + 200;
y2 = RESOLUTION_H / 2;

x1_target = 0;
x2_target = RESOLUTION_W;

lerp_progress = 0; // 'lerp' = Linear Interpolation Rate Progress (for the textbox going from a line to a box)
text_progress = 0;

text_message = "Default message text";
background = 0;

responses = ["Test response", "test response two"];
response_selected = 0;

obj_player_field.state = PLAYER_STATE_LOCKED;











