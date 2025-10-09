// Credit to Sara Spalding's video: https://www.youtube.com/watch?v=Sp623fof_Ck&list=PLPRT_JORnIurSiSB5r7UQAdzoEv-HF24L
function new_encounter(_enemies, _bg)
{
	instance_create_depth
	(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-9999,
		obj_battle,
		{enemies: _enemies, creator: id, battle_background: _bg}
	);
}

function battle_change_hp(_target, _amount, _notcrit_crit_heal, _outside_battle = 0, _alive_dead_or_either = 0)
{
	/// _notcrit_crit_heal:		0 = not crit,	1 = is crit,	2 = healing
	/// _alive_dead_or_either:	0 = alive only, 1 = dead only,	2 = any
	/// _outside_battle:		0 = in battle,	1 = outside
	
	// Damage/Heal fail conditions
	var _failed = false;
	if (_alive_dead_or_either == 0) && (_target.hp <= 0) _failed = true;
	if (_alive_dead_or_either == 1) && (_target.hp > 0) _failed = true;

	// Text colour
	var _col = c_white;									  // Default
	if		(_notcrit_crit_heal = 0)  { _col = c_white;	} // Not Crit
	else if (_notcrit_crit_heal = 1)  { _col = c_red;	} // Crit
	else if (_notcrit_crit_heal = 2)  { _col = c_lime;	} // Heal
	if (_failed) { _amount = "Failed";  _col = c_gray;  } // Failed

	// Battle text
	if (_outside_battle == 0) 
	{
		instance_create_depth
		(
			_target.x,
			_target.y,
			_target.depth - 1,
			obj_battle_floating_text,
			{font: fnt_fallout_6, col: _col, text: string(_amount)}
		);
	}
	
	// Apply damage/healing
	if (!_failed) _target.hp = clamp(_target.hp + _amount, 0, _target.hp_max);
}

function battle_change_ap(_target, _amount, _passive = 1)
{
	var _failed = false;
	if ((_target.ap + _amount) > _target.ap_max) { _target.ap = _target.ap_max; }
	if ((_target.ap + _amount) < 0) _failed = true;
	
	var _col = c_white;
	if (_amount > 0) _col = c_aqua;
	if (_failed)
	{
		_col = c_gray;
		_amount = "Failed";
	}
	// _passive: 0 = not passive (e.g. item used), 1 = passive (no text display)
	if (!_passive)
	{
		instance_create_depth
		(
			_target.x,
			_target.y,
			_target.depth - 1,
			obj_battle_floating_text,
			{font: fnt_fallout_6, col: _col, text: string(_amount)}
		);
	}
	if (!_failed) _target.ap = clamp(_target.ap + _amount, 0, _target.ap_max);
}

function battle_change_bet(_target, _amount, _passive = 1)
{
	var _failed = false;
	if ((_target.bet + _amount) > _target.bet_max) { _target.bet = _target.bet_max; }
	if ((_target.bet + _amount) < 0) _failed = true;
	if (!_failed) _target.bet = clamp(_target.bet + _amount, 0, _target.bet_max);
}