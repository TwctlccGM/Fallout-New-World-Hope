// Pause
global.pause = false;

/// Inventory macros
// Item Definitions
#macro ITEM_NONE 0
#macro ITEM_STIMPAK 1
#macro ITEM_NUKA_COLA 2
#macro ITEM_KEY 3
#macro ITEM_PISTOL 4
#macro ITEM_AXE 5
// Array Constants
#macro C_ITEM_TYPE 0
#macro C_ITEM_SPRITE 1
#macro C_ITEM_AMOUNT 2

// Inventory
global.item_array = array_create(0); // Create inventory array of arrays
//for(var _pos = 0; _pos < 5; _pos ++) // Initialise item type, sprite, and amount for each array
//{
//	global.item_array[_pos][C_ITEM_TYPE] = ITEM_NONE;
//	global.item_array[_pos][C_ITEM_SPRITE] = -1;
//	global.item_array[_pos][C_ITEM_AMOUNT] = 0;
//}

// Credit to Sara Spalding's video: https://www.youtube.com/watch?v=Sp623fof_Ck&list=PLPRT_JORnIurSiSB5r7UQAdzoEv-HF24L
// Action library
global.action_library =
{
	attack :
	{
		name : "Attack",
		description : "{0} attacks!",
		sub_menu_val : -1,
		ap_cost : 0,
		is_item : false,
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
	
	cleave :
	{
		name : "Cleave",
		description : "{0} hits all enemies!",
		sub_menu_val : "Abilities",
		ap_cost : 3,
		is_item : false,
		target_required : true,
		target_enemy_by_default : true, // 0: party/self, 1: enemy
		target_all : MODE.VARIES,
		user_animation : "attack",
		effect_sprite : spr_hit_ability_ph,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var _i = 0; _i < array_length(_targets); _i++)	// Hit all enemies
			{
				var _damage = irandom_range(15,20);	// Calculate damage
				if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75);	// Reduce damage if hitting multiple enemies
				battle_change_hp(_targets[_i], -_damage); // Inflict damage
			}
			battle_change_ap(_user, -ap_cost) // Update caster's AP
		}
	},
	
	stimpak :
	{
		name : "Stimpak",
		description : "{0} uses a Stimpak!",
		sub_menu_val : "Items",
		ap_cost : 1,
		is_item : true,
		item_id : ITEM_STIMPAK,
		target_required : true,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "cast",
		effect_sprite : spr_hit_ability_ph,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _heal = 100;
			battle_change_hp(_targets[0], _heal, 0); // Heal target
			battle_change_ap(_user, -ap_cost) // Update caster's AP
		}
	},
	
	nuka_cola :
	{
		name : "Nuka Cola",
		description : "{0} uses a Nuka Cola!",
		sub_menu_val : "Items2",
		ap_cost : 1,
		is_item : true,
		item_id : ITEM_NUKA_COLA,
		target_required : true,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "cast",
		effect_sprite : spr_hit_ability_ph,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			battle_change_ap(_targets[0], 5, 0) // Update target's AP
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
		sprites: { idle: spr_vaultie, attack: spr_vaultie, dodge: spr_vaultie, down: spr_vaultie},
		actions: [global.action_library.attack, global.action_library.stimpak, global.action_library.nuka_cola]
	}
	,
	{
		name: "Lobotomite",
		hp: 108,
		hp_max: 108,
		ap: 10,
		ap_max: 10,
		bet: 100,
		bet_max: 100,
		attack_power: 10,
		sprites: { idle: spr_lobotomite, attack: spr_lobotomite, dodge: spr_lobotomite, down: spr_lobotomite},
		actions: [global.action_library.attack, global.action_library.cleave]
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
		sprites: { idle: spr_cyberdog, attack: spr_cyberdog},
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