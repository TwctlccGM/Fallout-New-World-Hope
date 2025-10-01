// Pause
global.pause = false;

/// Inventory macros
// Item Definitions
#macro ITEM_STIMPAK 0
#macro ITEM_NUKA_COLA 1
#macro ITEM_DOCTORSBAG 2
#macro ITEM_MEDX 3
#macro ITEM_BATTLEBREW 4
#macro ITEM_KEYCARD 5
//#macro ITEM_PISTOL 0
//#macro ITEM_AXE 0

// Array Constants
#macro C_ITEM_TYPE 0
#macro C_ITEM_SPRITE 1
#macro C_ITEM_INVENTORY_SPRITE 2
#macro C_ITEM_AMOUNT 3

// Items (the array that's used to keep track of items and item usage)
global.item_array = array_create(6);

//										Name				Sprite					Inventory Sprite			Amount
global.item_array[ITEM_STIMPAK]		=	[ITEM_STIMPAK,		spr_item_stimpak,		spr_item_stimpak_white,		0];
global.item_array[ITEM_NUKA_COLA]	=	[ITEM_NUKA_COLA,	spr_item_nuka_cola,		spr_item_nuka_cola_white,	0];
global.item_array[ITEM_DOCTORSBAG]	=	[ITEM_DOCTORSBAG,	spr_item_doctorsbag,	spr_item_doctorsbag_white,	0];
global.item_array[ITEM_MEDX]		=	[ITEM_MEDX,			spr_item_medx,			spr_item_medx_white,		0];
global.item_array[ITEM_BATTLEBREW]	=	[ITEM_BATTLEBREW,	spr_item_battlebrew,	spr_item_battlebrew_white,	0];
global.item_array[ITEM_KEYCARD]		=	[ITEM_KEYCARD,		spr_item_keycard,		spr_item_keycard_white,		0];

// Inventory display
global.inventory_array = array_create(0);
// The inventory array uses the item's 'position' (where it visually appears in the menu) as its first index.
// This makes it easier to change how its displayed, but harder to manipulate the values.
// Representation below.

/*										Item Name			Item Sprite				Item Inventory Sprite		Item Amount
global.item_array[position]			=	[ITEM_STIMPAK,		spr_item_stimpak,		spr_item_stimpak_white,		0];
global.item_array[position]			=	[ITEM_NUKA_COLA,	spr_item_nuka_cola,		spr_item_nuka_cola_white,	0];
global.item_array[position]			=	[ITEM_DOCTORSBAG,	spr_item_doctorsbag,	spr_item_doctorsbag_white,	0];
global.item_array[position]			=	[ITEM_MEDX,			spr_item_medx,			spr_item_medx_white,		0];
global.item_array[position]			=	[ITEM_BATTLEBREW,	spr_item_battlebrew,	spr_item_battlebrew_white,	0];
global.item_array[position]			=	[ITEM_KEYCARD,		spr_item_keycard,		spr_item_keycard_white,		0];*/

// Credit to Sara Spalding's video: https://www.youtube.com/watch?v=Sp623fof_Ck&list=PLPRT_JORnIurSiSB5r7UQAdzoEv-HF24L
// Action library
global.action_library =
{
	/// Basic attack
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
		effect_sprite : spr_effect_hit_basic,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = floor(_user.attack_value - _targets[0].armour_value);
			if (_damage < 0) { _damage = 0; }; // Cap lowest damage at '0', otherwise it'll heal the ene
			battle_change_hp(_targets[0], -_damage, 0);
		}
	},
	
	/// Abilities
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
		effect_sprite : spr_effect_hit_ability,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)	// Hit all enemies
			{
				var _damage = floor((_user.attack_value * 1.5) - _targets[i].armour_value);	// Calculate damage
				if (_damage < 0) { _damage = 0; }; // Cap lowest damage at '0', otherwise it'll heal the ene
				battle_change_hp(_targets[i], -_damage); // Inflict damage
			}
			battle_change_ap(_user, -ap_cost) // Update caster's AP
		}
	},
	
	/// Items
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
		effect_sprite : spr_effect_restore_HP,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _heal = 50;
			battle_change_hp(_targets[0], _heal, 0); // Heal target
			battle_change_ap(_user, -ap_cost) // Update caster's AP
		}
	},
	
	nuka_cola :
	{
		name : "Nuka Cola",
		description : "{0} uses a Nuka Cola!",
		sub_menu_val : "Items",
		ap_cost : 0,
		is_item : true,
		item_id : ITEM_NUKA_COLA,
		target_required : true,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "cast",
		effect_sprite : spr_effect_restore_AP,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			battle_change_ap(_targets[0], 5, 0) // Update target's AP
		}
	},
	
	battle_brew :
	{
		name : "Battle Brew",
		description : "{0} uses a Battle Brew!",
		sub_menu_val : "Items",
		ap_cost : 0,
		is_item : true,
		item_id : ITEM_BATTLEBREW,
		target_required : true,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "cast",
		effect_sprite : spr_effect_damageboost,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			// TODO: Replace with a dedicated Battle Brew function later
			_targets[0].attack_value = _targets[0].attack_value * 1.5;
			_targets[0].armour_value = _targets[0].armour_value + 5;
			
		}
	},
	
	/// Run away
	flee :
	{
		name : "Flee",
		description : "{0} attacks!",
		sub_menu_val : -1,
		ap_cost : 0,
		is_item : false,
		target_required : false,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "dodge",
		effect_sprite : spr_none,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			with (obj_battle) 
			{
				for (var i = 0; i < array_length(global.party); i++)
				{
					global.party[i].hp = party_units[i].hp;
				}
				instance_activate_all();
				//instance_destroy(creator);
				//instance_destroy(obj_battle);
				game_restart();
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
		attack_value: 10,
		armour_value: 0,
		sprites: { idle: spr_vaultie, attack: spr_vaultie, dodge: spr_vaultie, down: spr_vaultie_down, inventory: spr_vaultie_white },
		actions: [global.action_library.attack, global.action_library.cleave, global.action_library.stimpak, global.action_library.nuka_cola, global.action_library.battle_brew] // global.action_library.flee
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
		attack_value: 20,
		armour_value: 5,
		sprites: { idle: spr_lobotomite, attack: spr_lobotomite, dodge: spr_lobotomite, down: spr_lobotomite_down, inventory: spr_lobotomite_white },
		actions: [global.action_library.attack, global.action_library.cleave, global.action_library.stimpak, global.action_library.nuka_cola, global.action_library.battle_brew] // global.action_library.flee
	}
	,
	{
		name: "Cyberdog",
		hp: 9,
		hp_max: 999,
		ap: 10,
		ap_max: 10,
		bet: 100,
		bet_max: 100,
		attack_value: 15,
		armour_value: 5,
		sprites: { idle: spr_cyberdog, attack: spr_cyberdog, dodge: spr_cyberdog, down: spr_cyberdog, inventory: spr_cyberdog_white },
		actions: [global.action_library.attack, global.action_library.cleave, global.action_library.stimpak, global.action_library.nuka_cola, global.action_library.battle_brew] // global.action_library.flee
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
		attack_value: 10,
		armour_value: 5,
		sprites: { idle: spr_orderly, attack: spr_orderly},
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
		attack_value: 10,
		armour_value: 0,
		sprites: { idle: spr_cyberdog_enemy, attack: spr_cyberdog_enemy},
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
	turret_ceiling:
	{
		name: "Turret",
		hp: 30,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		attack_value: 20,
		armour_value: 5,
		sprites: { idle: spr_turret_ceiling, attack: spr_turret_ceiling},
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
	trauma_harness:
	{
		name: "Harness",
		hp: 30,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		attack_value: 10,
		armour_value: 5,
		sprites: { idle: spr_traumaharness, attack: spr_traumaharness},
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