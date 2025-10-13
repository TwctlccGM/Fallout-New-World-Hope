/// @description
lerp_progress += (1 - lerp_progress) / 50;
text_progress += 0.5;

x1 = lerp(x1, x1_target, lerp_progress);
x2 = lerp(x2, x2_target, lerp_progress);

// Cycle through responses
var _key_up = keyboard_check_pressed(vk_up);
var _key_down = keyboard_check_pressed(vk_down);
response_selected += (_key_down - _key_up);
var _max = array_length(responses) - 1;
var _min = 0;
if (response_selected > _max) response_selected = _min;
if (response_selected < _min) response_selected = _max;

if (keyboard_check_pressed(vk_space))
{
	var _message_length = string_length(text_message);
	if (text_progress >= _message_length) // Shown the whole message
	{
		instance_destroy(); // Remove message
	}
	else
	{
		if (text_progress > 2) // Hasn't shown the whole message
		{
				text_progress = _message_length; // Show whole message
		}
	}
}









