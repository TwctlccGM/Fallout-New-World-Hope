// @desc Menu - makes a menu, options provided in the form [["name, function, argument], [...]]
function menu(_x, _y, _options, _description = -1, _width = undefined, _height = undefined)
{
	with (instance_create_depth(_x, _y, -99999, obj_menu))
	{
		options = _options;
		description = _description;
		var _options_count = array_length(_options);
		visible_options_max = _options_count;
		
		// Set up size
		x_margin = 10;
		y_margin = 8;
		draw_set_font(fnt_fallout_6);
		height_line = 12;
		
		// Auto width
		if (_width == undefined)
		{
			width = 1;
			if (description !=  -1) width = max(width, string_width(_description));
			for (var _i = 0; _i < _options_count; _i++)
			{
				width = max(width, string_width(_options[_i][0]));
			}
			width_full = width + x_margin * 2;
		} else width_full = _width;
		
		// Auto height
		if (_height == undefined)
		{
			height = height_line * (_options_count + (description != -1));
			height_full = height + y_margin * 2;
		}
		else
		{
			height_full = _height;
			// scrolling?
			if (height_line * (_options_count + (description != -1)) > _height - (y_margin * 2))
			{
				scrolling = true;
				visible_options_max = (_height - y_margin * 2) div height_line;
			}
		}
	}
}

function sub_menu(_options)
{
	// store old options in array and increase submenu level
	options_above[sub_menu_level] = options;
	sub_menu_level++;
	// display submenu's options
	options = _options;
	hover = 0;
}

function menu_go_back()
{
	sub_menu_level--;
	options = options_above[sub_menu_level];
	hover = 0;
}

function menu_select_action(_user, _action)
{
	with (obj_menu) active = false;
	
	// Activate the targeting cursor if needed, or simply begin the action
	with (obj_battle) 
	{
		if (_action.target_required)
		{
			with (cursor)
			{
				active = true;
				active_action = _action;
				target_all = _action.target_all;
				if (target_all == MODE.VARIES) target_all = true; // "toggle" starts as all by default
				active_user = _user;
				
				// Which side to target by default?
				if (_action.target_enemy_by_default) // Target enemy by default
				{
					target_index = 0;
					target_side = obj_battle.enemy_units;
					active_target = obj_battle.enemy_units[target_index];
				}
				else
				{
					target_side = obj_battle.party_units;
					active_target = active_user
					;
					var _find_self = function(_element, _user)
					{
						return (_element == active_target)
					}
					target_index = array_find_index(obj_battle.party_units, _find_self);
				}
			}
		}
		else
		{
			// If no target needed, begin the action and end the menu
			begin_action(_user, _action, -1);
			with (obj_menu) instance_destroy();
		}
	}
}