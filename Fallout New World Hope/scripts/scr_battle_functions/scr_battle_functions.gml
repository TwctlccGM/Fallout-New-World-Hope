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
	
	// Increase BET if player unit takes damage
	if ((_target.is_player_unit) && (_amount != "Failed") && (_amount < 0))
	{
		battle_change_bet(_target, _amount, true);
	}
}

function battle_change_ap(_target, _use_agility = 0, _amount = 0, _display_text = 0)
{
	// _use_agility:	0 = use a raw value (_amount), 1 = use _target's agility stat
	// _amount:			Default int value of 0
	// _display_text:	0 = no text (e.g. ability used), 1 = show text (e.g. item used)
	
	var _failed = false;
	if (_use_agility = 1)
	{
		// Agility formula below results in:	| 0 = 0 AP | 1-3 = 1 AP | 4-6 = 2 AP | 7-9 = 3 AP | 10 = 4 AP |
		_amount = floor((_target.agility + 2) / 3);
	}
	
	if ((_target.ap + _amount) > _target.ap_max) { _target.ap = _target.ap_max; }
	if ((_target.ap + _amount) < 0) _failed = true;
	
	var _col = c_white;
	if (_amount > 0) _col = c_aqua;
	if (_failed)
	{
		_col = c_gray;
		_amount = "Failed";
	}

	if (_display_text)
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

function battle_change_bet(_target, _amount, _is_damage = true)
{
	var _failed = false;
	var _bet_amount = _amount;
	// If it's not damage taken, it's directly affecting BET amount (e.g. after using a BET attack) so it doesn't need the formula
	if (_is_damage)
	{
		/// BET amount formula:
		//   _bet_amount = clamp(floor((floor((abs(DMG) * 300) / HP_max) * (CHA / 10))), 1, 100); 
		//
		/// BET amount key:
		//	 abs(DMG) =  Damage taken in HP
		//	 HP_max	  =  Character's max HP
		//	 CHA	  =  Character's Charisma stat
		_bet_amount = clamp(floor((floor((abs(_amount) * 300) / _target.hp_max ) * (_target.charisma / 10))), 1, 100); 
	}
	
	if ((_target.bet + _bet_amount) > _target.bet_max) { _target.bet = _target.bet_max; }
	if ((_target.bet + _bet_amount) < 0) _failed = true;
	if (!_failed) _target.bet = clamp(_target.bet + _bet_amount, 0, _target.bet_max);
}