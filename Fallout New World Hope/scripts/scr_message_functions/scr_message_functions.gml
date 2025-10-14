function new_text_box() {
	// @arg Message
	// @arg Background
	// @arg [Responses]
	var _obj = obj_text;
	if (instance_exists(obj_text)) _obj = obj_text_queued; else _obj = obj_text;
	with (instance_create_layer(0, 0, "Instances_Menus", _obj))
	{
		text_message = argument[0];
		if (instance_exists(other)) origin_instance = other.id else origin_instance = noone;
		if (argument_count > 1) background = argument[1]; else background = 1;
		if (argument_count > 2)
		{
			// Trim markers from responses (in entity variables)
			responses = [];
			array_copy(responses, 0, argument[2], 0, array_length(argument[2]));
			for (var i = 0; i < array_length(responses); i++)
			{
				var _marker_position = string_pos(":", responses[i]);
				response_scripts[i] = string_copy(responses[i], 1, _marker_position - 1);
				response_scripts[i] = real(responses[i]);
				responses[i] = string_delete(responses[i], 1, _marker_position);
			}
		}
		else
		{
			responses = [-1];
			response_scripts = [-1];
		}
	}
	
	with (obj_player_field)
	{
		if (state != PLAYER_STATE_LOCKED)
		{	
			last_state = state;
			state = PLAYER_STATE_LOCKED;
		}
	}
}