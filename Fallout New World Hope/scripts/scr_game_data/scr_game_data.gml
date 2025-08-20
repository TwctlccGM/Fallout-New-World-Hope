// Credit to Sara Spalding's video: https://www.youtube.com/watch?v=Sp623fof_Ck&list=PLPRT_JORnIurSiSB5r7UQAdzoEv-HF24L
// Action library
global.action_library =
{
	attack :
	{
		name : "Attack",
		description : "{0} attacks!",
		sub_menu_val : -1,
		target_required : true,
		target_enemy_by_default : true,
		target_all : MODE.NEVER,
		user_animation : "attack",
		effect_sprite : spr_hit_ph,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.attack_power + random_range(-_user.attack_power * 0.25, _user.attack_power * 0.25));
			battle_change_hp(_targets[0], -_damage, 0);
		}
	},
	ice :
	{
		name : "Ice",
		description : "{0} casts Ice!",
		sub_menu_val : "Magic",
		ap_cost : 1,
		target_required : true,
		target_enemy_by_default : true, // 0: party/self, 1: enemy
		target_all : MODE.VARIES,
		user_animation : "cast",
		effect_sprite : spr_icehit_ph,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			//var _damage = irandom_range(10, 15);
			//battle_change_hp(_targets[0], -_damage);
			// battle_change_ap(_user, -mp_cost)
			if (_user.ap >= ap_cost)
			{
				for (var _i = 0; _i < array_length(_targets); _i++)
				{
					var _damage = irandom_range(15,20);
					if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75);
					battle_change_hp(_targets[_i], -_damage);
				}
				battle_change_ap(_user, -ap_cost)
			}
		}
	}
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2,
}

// Party data
global.party =
[
	{
		name: "Vaultie",
		hp: 108,
		hp_max: 108,
		ap: 10,
		ap_max: 10,
		bet: 100,
		bet_max: 100,
		attack_power: 10,
		sprites: { idle: spr_placeholder, attack: spr_placeholder, dodge: spr_placeholder, down: spr_placeholder},
		actions: [global.action_library.attack]
	}
	,
	{
		name: "Lobotomite",
		hp: 108,
		hp_max: 108,
		ap: 1,
		ap_max: 1,
		bet: 100,
		bet_max: 100,
		attack_power: 10,
		sprites: { idle: spr_placeholder, attack: spr_placeholder, dodge: spr_placeholder, down: spr_placeholder},
		actions: [global.action_library.attack, global.action_library.ice]
	}
];

// Enemy data
global.enemies =
{
	orderly_mk1:
	{
		name: "Orderly",
		hp: 30,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		attack_power: 10,
		sprites: { idle: spr_placeholder, attack: spr_placeholder},
		actions: [global.action_library.attack],
		xp: 100,
		AI_script: function()
		{
			/// Enemy turn AI goes here
			// Attack random party member
			var _action = actions[0];
			var _possible_targets = array_filter(obj_battle.party_units, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possible_targets[irandom(array_length(_possible_targets) - 1)];
			return [_action, _target];
		}
	}
	,
	cyberdog_police:
	{
		name: "P.CybDog",
		hp: 30,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		attack_power: 10,
		sprites: { idle: spr_placeholder, attack: spr_placeholder},
		actions: [global.action_library.attack],
		xp: 100,
		AI_script: function()
		{
			/// Enemy turn AI goes here
			// Attack random party member
			var _action = actions[0];
			var _possible_targets = array_filter(obj_battle.party_units, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possible_targets[irandom(array_length(_possible_targets) - 1)];
			return [_action, _target];	
		}
	}
}