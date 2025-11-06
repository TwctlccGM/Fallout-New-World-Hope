/*function new_text_box() {
	// @arg Message
	// @arg Background
	// @arg [Responses]
	var _obj = obj_text;
	if (instance_exists(obj_text)) _obj = obj_text_queued; else _obj = obj_text;
	with (instance_create_layer(0, 0, "Instances_Menus", _obj))
	{
		text_message = argument[0];
		if (!obj_inventory.draw_inventory)
		{
			if (instance_exists(other)) origin_instance = other.id else origin_instance = noone;
		}
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
}*/

function new_text_box(_message, _box_type = DIALOGUE, _background = 1, _responses = [-1]) {

    // Defaults
    if (argument_count < 2 || !is_real(_box_type))     _box_type = DIALOGUE;
    if (argument_count < 3 || !is_real(_background))   _background = 1;
    if (argument_count < 4 || !is_array(_responses))   _responses = [-1];

    var _obj = obj_text;
    if (instance_exists(obj_text)) _obj = obj_text_queued;

    with (instance_create_layer(0, 0, "Instances_Menus", _obj))
    {
        text_message = _message;
        box_type     = _box_type;
        background   = _background;

        // Set origin
        if (!obj_inventory.draw_inventory) {
            origin_instance = instance_exists(other) ? other.id : noone;
        }

        // Responses
        responses = [];
        response_scripts = [];

        if (array_length(_responses) > 0 && _responses[0] != -1)
        {
            array_copy(responses, 0, _responses, 0, array_length(_responses));

            for (var i = 0; i < array_length(responses); i++)
            {
                var _string = responses[i];
                var _pos = string_pos(":", _string);
                var _resp = string_copy(_string, 1, _pos - 1);

                response_scripts[i] = real(_resp);
                responses[i] = string_delete(_string, 1, _pos);
            }
        }
        else
        {
            responses = [-1];
            response_scripts = [-1];
        }
    }

    // Lock player movement
    with (obj_player_field)
    {
        if (state != PLAYER_STATE_LOCKED)
        {
            last_state = state;
            state = PLAYER_STATE_LOCKED;
        }
    }
	
	// Lock inventory input
    with (obj_inventory)
    {
        if (state != INVENTORY_STATE_LOCKED)
        {
            last_state = state;
            state = INVENTORY_STATE_LOCKED;
        }
    }
}