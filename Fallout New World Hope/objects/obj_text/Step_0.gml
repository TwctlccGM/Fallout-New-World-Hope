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

var _message_length = string_length(text_message);
if (box_type != DIALOGUE)
{
	text_progress = _message_length; // Show whole message
}

if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(ord("X")))
{
	obj_player_field.delay = 2;
	if (text_progress >= _message_length) // Already shown the whole message
	{
		if (responses[0] != -1)
		{
			with (origin_instance) dialogue_responses(other.response_scripts[other.response_selected]);
		}
		
		if (instance_exists(obj_text_queued))
		{
			with (obj_text_queued) 
			{
				ticket--;
				if (ticket == 0) instance_change(obj_text, true);
			}
		}
		else
		{
			with (obj_player_field) state = last_state;	
			with (obj_inventory) state = last_state;	
		}
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









