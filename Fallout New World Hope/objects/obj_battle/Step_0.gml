/// @description
battle_state();

// End battle when enemies are dead
var _enemies = obj_battle.enemy_units;

if (array_any(_enemies, function(_element, _index) {return _element.hp > 0; }) == false) 
{
	instance_activate_all();
	instance_destroy(creator);
	instance_destroy(obj_battle);
};

// Cursor control
if (cursor.active)
{
	with (cursor)
	{
		// Input
		var _key_up = keyboard_check_pressed(vk_up);
		var _key_down = keyboard_check_pressed(vk_down);
		var _key_left = keyboard_check_pressed(vk_left);
		var _key_right = keyboard_check_pressed(vk_right);
		var _key_toggle = false;
		var _key_confirm = false;
		var _key_cancel = false;
		confirm_delay++;
		if (confirm_delay > 1)
		{
			_key_confirm = keyboard_check_pressed(ord("Z"));
			_key_cancel = keyboard_check_pressed(ord("X"));
			_key_toggle = keyboard_check_pressed(vk_shift);
		}
		var _move_h = _key_right - _key_left;
		var _move_v = _key_down - _key_up;
		
		if (_move_h == -1) target_side = obj_battle.party_units;
		if (_move_h == 1) target_side = obj_battle.enemy_units;
		
		// Verify target list
		if (target_side == obj_battle.enemy_units)
		{
			target_side = array_filter(target_side, function(_element, _index)
			{
				return _element.hp > 0;
			});
		}
		
		// Move between targets
		if (target_all == false) // Single target mode
		{
			if (_move_v == 1) target_index++;
			if (_move_v == -1) target_index--;
			
			// Wrap
			var _targets = array_length(target_side);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
			
			// Identify target
			active_target = target_side[target_index];
			
			// Toggle all mode
			if (active_action.target_all == MODE.VARIES) && (_key_toggle) // Switch to all mode
			{
				target_all = true;
			}
		}
		else // Target all mode
		{
			active_target = target_side;
			if (active_action.target_all == MODE.VARIES) && (_key_toggle) // Switch to single mode
			{
				target_all = false;
			}
		}
		
		// Confirm action
		if (_key_confirm)
		{
			with (obj_battle) begin_action(cursor.active_user, cursor.active_action, cursor.active_target);
			with (obj_menu) instance_destroy();
			active = false;
			confirm_delay = 0;
		}
		
		// Cancel & return to menu
		if (_key_cancel) && (!_key_confirm)
		{
			with (obj_menu) active = true;
			active = false;
			confirm_delay = 0;
		}
	}
}