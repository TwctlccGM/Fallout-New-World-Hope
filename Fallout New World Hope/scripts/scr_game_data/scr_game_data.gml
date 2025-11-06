// Resolution etc.
#macro RESOLUTION_W 320
#macro RESOLUTION_H 180
#macro TILE_SIZE	16
//surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);

// Pause
global.pause = false;

/// Inventory macros
// Item Definitions
#macro ITEM_STIMPAK		0
#macro ITEM_DOCTORSBAG	1
#macro ITEM_NUKA_COLA	2
#macro ITEM_MEDX		3
#macro ITEM_BATTLEBREW	4
#macro ITEM_KEYCARD		5
//#macro ITEM_PISTOL	0
//#macro ITEM_AXE		0

// Array Constants
#macro C_ITEM_TYPE				0
#macro C_ITEM_SPRITE			1
#macro C_ITEM_INVENTORY_SPRITE	2
#macro C_ITEM_AMOUNT			3
#macro C_ITEM_NAME				4

// Items (the array that's used to keep track of items and item usage)
global.item_array = array_create(6);

//										ID					Sprite					Inventory Sprite			Amount	Name
global.item_array[ITEM_STIMPAK]		=	[ITEM_STIMPAK,		spr_item_stimpak,		spr_item_stimpak_white,		0,		"Stimpak"		];
global.item_array[ITEM_DOCTORSBAG]	=	[ITEM_DOCTORSBAG,	spr_item_doctorsbag,	spr_item_doctorsbag_white,	0,		"Doctor's Bag"	];
global.item_array[ITEM_NUKA_COLA]	=	[ITEM_NUKA_COLA,	spr_item_nuka_cola,		spr_item_nuka_cola_white,	0,		"Nuka Cola"		];
global.item_array[ITEM_MEDX]		=	[ITEM_MEDX,			spr_item_medx,			spr_item_medx_white,		0,		"Med-X"			];
global.item_array[ITEM_BATTLEBREW]	=	[ITEM_BATTLEBREW,	spr_item_battlebrew,	spr_item_battlebrew_white,	0,		"Battle Brew"	];
global.item_array[ITEM_KEYCARD]		=	[ITEM_KEYCARD,		spr_item_keycard,		spr_item_keycard_white,		0,		"Keycard"		];

// Inventory display
global.inventory_array = array_create(0);
// The inventory array uses the item's 'position' (where it visually appears in the menu) as its first index.
// This makes it easier to change how its displayed, but harder to manipulate the values.
// Representation below.
/*										Name				Sprite					Inventory Sprite			Amount
global.item_array[position]			=	[ITEM_STIMPAK,		spr_item_stimpak,		spr_item_stimpak_white,		0];
global.item_array[position]			=	[ITEM_NUKA_COLA,	spr_item_nuka_cola,		spr_item_nuka_cola_white,	0];
global.item_array[position]			=	[ITEM_DOCTORSBAG,	spr_item_doctorsbag,	spr_item_doctorsbag_white,	0];
global.item_array[position]			=	[ITEM_MEDX,			spr_item_medx,			spr_item_medx_white,		0];
global.item_array[position]			=	[ITEM_BATTLEBREW,	spr_item_battlebrew,	spr_item_battlebrew_white,	0];
global.item_array[position]			=	[ITEM_KEYCARD,		spr_item_keycard,		spr_item_keycard_white,		0];*/

/// Action library
// Rules:
// 1: Attack names can only be 13 characters long (otherwise it doesn't fit into the box)
global.action_library =
{
	/// Basic attack
	attack :
	{
		name : "Attack",
		description_new : "Single-target damage",
		description : "{0} attacks!",
		sub_menu_val : -1,
		ap_cost : 0,
		bet_cost : 0,
		is_item : false,
		target_required : true,
		target_enemy_by_default : true,
		target_all : MODE.NEVER,
		user_animation : "attack",
		effect_sprite : spr_effect_hit_basic,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _attack_power =											// Calculate user's attack power
			max(_user.strength, _user.perception);						//	User's highest damaging stat (STR/PER)
			
			var _crit = 0;												// Calculate if it's a critical hit
			if ((floor(random_range(0, 100)) <= _user.luck))			//	 User's LCK / 100
			{ _crit = 1; };
			
			var _damage = 0;											// Calculate damage dealt to target
			if (_crit == 0) {											//	If Normal hit
				_damage =
				floor((_attack_power * _user.attack_mult)				//		User attack (STR/PER)
				- (_targets[0].endurance * _targets[0].defense_mult));	//		Target defense
			}
			if (_crit == 1) {											//	 If Critical hit
				_damage =
				floor((_attack_power * _user.attack_mult * 2)			//		User attack (STR/PER)
				- (_targets[0].endurance * _targets[0].defense_mult));	//		Target defense
			}
			if (_damage <= 0) { _damage = 1; };							// Cap lowest damage at '1'
			battle_change_hp(_targets[0], -_damage, _crit, 0);			// Inflict damage on target
		}
	},
	
	/// Abilities
	targeted_shot :
	{
		name : "Targeted Shot",
		description_new : "Reduces enemy defense",
		description : "{0} exposes a weak point!",
		sub_menu_val : "Abilities",
		ap_cost : 5,
		bet_cost : 0,
		is_item : false,
		target_required : true,
		target_enemy_by_default : true,
		target_all : MODE.NEVER,
		user_animation : "attack",
		effect_sprite : spr_effect_debuff_blue_anim,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _crit = 0;													// Calculate if it's a critical hit
			if ((floor(random_range(0, 100)) <= _user.luck))				//	 User's LCK / 100
			{ _crit = 1; };
			
			var _damage = 0;												// Calculate damage dealt to target
			if (_crit == 0) {												//	If Normal hit
				_damage =
				floor((_user.perception * _user.attack_mult)				//		User attack (PER)
					- (_targets[0].endurance * _targets[0].defense_mult));	//		Target defense
			}
			if (_crit == 1) {												//	If Critical hit
				_damage =
				floor((_user.perception * _user.attack_mult * 2)			//		User attack (PER)
					- (_targets[0].endurance * _targets[0].defense_mult));	//		Target defense
			}
			if (_damage <= 0) { _damage = 1; };								// Cap lowest damage at '1'
			battle_change_hp(_targets[0], -_damage, _crit, 0);				// Inflict damage on target
			_targets[0].defense_mult -= 0.5;								// Reduce target's defense
			battle_change_ap(_user, 0, -ap_cost, 0);						// Update user's AP
		}
	},
	
	axe_cleave :
	{
		name : "Axe Cleave",
		description_new : "Hits all enemies",
		description : "{0} hits all enemies!",
		sub_menu_val : "Abilities",
		ap_cost : 5,
		bet_cost : 0,
		is_item : false,
		target_required : true,
		target_enemy_by_default : true,
		target_all : MODE.ALWAYS,
		user_animation : "attack",
		effect_sprite : spr_effect_hit_ability,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{	
			var _crit = 0;														// Calculate if it's a critical hit
			if ((floor(random_range(0, 100)) <= _user.luck))					//	 User's LCK / 100
			{ _crit = 1; };

			for (var i = 0; i < array_length(_targets); i++)					// Hit all enemies
			{
				var _damage = 0;												// Calculate damage dealt to target
				if (_crit == 0) {												//	If Normal hit
					_damage =
					floor((_user.strength * _user.attack_mult)					//		User attack (STR)
						- (_targets[i].endurance * _targets[i].defense_mult));	//		Target defense
				}
				if (_crit == 1) {												//	If Critical hit
					_damage =
					floor((_user.strength * _user.attack_mult * 2)				//		User attack (STR)
						- (_targets[i].endurance * _targets[i].defense_mult));	//		Target defense
				}
				if (_damage <= 0) { _damage = 1; };								// Cap lowest damage at '1'
				battle_change_hp(_targets[i], -_damage, _crit, 0);				// Inflict damage on target
			}
			battle_change_ap(_user, 0, -ap_cost, 0);							// Update user's AP
		}
	},
	
	sonic_bark :
	{
		name : "Sonic Bark",
		description_new : "Reduce all enemies' attack power",
		description : "{0} weakens all enemies!",
		sub_menu_val : "Abilities",
		ap_cost : 5,
		bet_cost : 0,
		is_item : false,
		target_required : true,
		target_enemy_by_default : true,
		target_all : MODE.ALWAYS,
		user_animation : "attack",
		effect_sprite : spr_effect_debuff_red_anim,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{			
			var _crit = 0;														// Calculate if it's a critical hit
			if ((floor(random_range(0, 100)) <= _user.luck))					//	User's LCK / 100
			{ _crit = 1; };

			for (var i = 0; i < array_length(_targets); i++)					// Hit all enemies
			{
				var _damage = 0;												// Calculate damage dealt to target
				if (_crit == 0) {												//	If Normal hit
					_damage =
					floor((_user.perception * _user.attack_mult)				//		User attack (PER)
						- (_targets[i].endurance * _targets[i].defense_mult));	//		Target defense
				}
				if (_crit == 1) {												//	If Critical hit
					_damage =
					floor((_user.perception * _user.attack_mult * 2)			//		User attack (PER)
						- (_targets[i].endurance * _targets[i].defense_mult));	//		Target defense
				}
				if (_damage <= 0) { _damage = 1; };								// Cap lowest damage at '1'
				battle_change_hp(_targets[i], -_damage, _crit, 0);				// Inflict damage on target
				_targets[i].attack_mult -= 0.5;									// Reduce target's attack value
			}
			battle_change_ap(_user, 0, -ap_cost, 0);							// Update user's AP
		}
	},
	
	/// Bet
	bottlecap_mine :
	{
		name : "Cap Mine   (25)",
		description_new : "Hits all enemies",
		description : "{0} throws an explosive!",
		sub_menu_val : "Bet",
		ap_cost : 0,
		bet_cost : 25,
		is_item : false,
		target_required : true,
		target_enemy_by_default : true,
		target_all : MODE.ALWAYS,
		user_animation : "attack",
		effect_sprite : spr_effect_hit_ability,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _crit = 0;														// Calculate if it's a critical hit
			if ((floor(random_range(0, 100)) <= _user.luck))					//	User's LCK / 100
			{ _crit = 1; };

			for (var i = 0; i < array_length(_targets); i++)					// Hit all enemies
			{
				var _damage = 0;												// Calculate damage dealt to target
				if (_crit == 0) {												//	If Normal hit
					_damage =
					floor((_user.intelligence * _user.attack_mult)				//		User attack (INT)
						- (_targets[i].endurance * _targets[i].defense_mult));	//		Target defense
				}
				if (_crit == 1) {												//	If Critical hit
					_damage =
					floor((_user.intelligence * _user.attack_mult * 2)			//		User attack (INT)
						- (_targets[i].endurance * _targets[i].defense_mult));	//		Target defense
				}
				if (_damage <= 0) { _damage = 1; };								// Cap lowest damage at '1'
				battle_change_hp(_targets[i], -_damage, _crit, 0);				// Inflict damage on target
			}
			battle_change_bet(_user, -bet_cost, false);							// Update user's BET
		}
	},
	
	/// Items
	stimpak :
	{
		name : "Stimpak",
		description_new : "Heals an ally",
		description : "{0} uses a Stimpak!",
		sub_menu_val : "Items",
		ap_cost : 0,
		bet_cost : 0,
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
			var _heal = (_user.intelligence * 10);			// Calculate heal
			battle_change_hp(_targets[0], _heal, 2, 0, 0);	// Heal target
		}
	},
	
	doctors_bag :
	{
		name : "Doc Bag",
		description_new : "Revives an ally",
		description : "{0} uses a Doc Bag!",
		sub_menu_val : "Items",
		ap_cost : 0,
		bet_cost : 0,
		is_item : true,
		item_id : ITEM_DOCTORSBAG,
		target_required : true,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "cast",
		effect_sprite : spr_effect_restore_HP,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _heal = (_user.intelligence * 10);			// Calculate heal
			battle_change_hp(_targets[0], _heal, 2, 0, 1);	// Resurrect target
		}
	},
	
	nuka_cola :
	{
		name : "Nuka Cola",
		description_new : "Restores AP to an ally",
		description : "{0} uses a Nuka Cola!",
		sub_menu_val : "Items",
		ap_cost : 0,
		bet_cost : 0,
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
			var _heal = (_user.intelligence);		// Calculate AP restored
			battle_change_ap(_user, 0, _heal, 1);	// Restore target's AP
		}
	},
	
	battle_brew :
	{
		name : "Battle Brew",
		description_new : "Increases an ally's attack",
		description : "{0} uses a Battle Brew!",
		sub_menu_val : "Items",
		ap_cost : 0,
		bet_cost : 0,
		is_item : true,
		item_id : ITEM_BATTLEBREW,
		target_required : true,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "cast",
		effect_sprite : spr_effect_buff_damage,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			_targets[0].attack_mult += (_user.intelligence / 10); // Increase target's attack value
		}
	},
	
	med_x :
	{
		name : "Med-X",
		description_new : "Increases an ally's defense",
		description : "{0} uses a Med-X!",
		sub_menu_val : "Items",
		ap_cost : 0,
		bet_cost : 0,
		is_item : true,
		item_id : ITEM_MEDX,
		target_required : true,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "cast",
		effect_sprite : spr_effect_buff_armour,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			_targets[0].defense_mult += (_user.intelligence / 10); // Increase target's armour value
		}
	},
	
	/// Run away
	flee :
	{
		name : "Flee",
		description_new : "Escape from battle",
		description : "{0} flees!",
		sub_menu_val : -1,
		ap_cost : 0,
		bet_cost : 0,
		is_item : false,
		target_required : false,
		target_enemy_by_default : false,
		target_all : MODE.NEVER,
		user_animation : "dodge",
		effect_sprite : spr_none,
		effect_on_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			/// This function restarts the game to end the battle. TODO: Make this better.
			with (obj_battle) 
			{
				for (var i = 0; i < array_length(global.party); i++)
				{
					global.party[i].hp = party_units[i].hp;
				}
				instance_activate_all();
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

/// Party data
// 'party_data' is all of the possible party members data
global.party_data =
[
	{
		// Name
		name: "Vaultie",
		is_player_unit: true,
		level: 1,
		// SPECIAL
		strength: 100,		// Power of melee attacks
		perception: 6,		// Power of ranged attacks
		endurance: 3,		// Base defense value
		charisma: 6,		// BET rate (and OOC bartering)
		intelligence: 7,	// Item effectiveness
		agility: 6,			// Turn order and AP rate per turn (0 = 0 AP,  1-3 = 1 AP,  4-6 = 2 AP,  7-9 = 3 AP, 10 = 4 AP)
		luck: 100,			// Crit rate
		// Stats
		hp: 108,
		hp_max: 108,
		ap: 10,
		ap_max: 10,
		bet: 50,
		bet_max: 100,
		attack_mult: 1,
		defense_mult: 1,
		xp_total: 0,
		xp_to_next_level: 50,
		special_points: 0,
		perk_points: 0,
		// Sprites
		sprites: { 
			idle: spr_vaultie_battle, 
			attack: spr_vaultie_battle, 
			dodge: spr_vaultie_battle, 
			down: spr_vaultie_downed, 
			inventory: spr_vaultie_white 
		},
		// Actions
		actions: [
		// Basic attack
		global.action_library.attack, 
		// Abilities
		global.action_library.targeted_shot, 
		// Bet
		global.action_library.bottlecap_mine, 
		// Items
		global.action_library.stimpak, 
		global.action_library.doctors_bag, 
		global.action_library.nuka_cola, 
		global.action_library.battle_brew, 
		global.action_library.med_x
		// global.action_library.flee
		]
	}
	,
	{
		// Name
		name: "Lobotomite",
		is_player_unit: true,
		level: 1,
		// SPECIAL
		strength: 9,		// Power of melee attacks
		perception: 4,		// Power of ranged attacks
		endurance: 9,		// Base defense value
		charisma: 3,		// BET rate (and OOC bartering)
		intelligence: 3,	// Item effectiveness
		agility: 9,			// Turn order and AP rate per turn
		luck: 3,			// Crit rate
		// Stats
		hp: 108,
		hp_max: 108,
		ap: 10,
		ap_max: 10,
		bet: 0,
		bet_max: 100,
		attack_mult: 1,
		defense_mult: 1,
		xp_total: 0,
		xp_to_next_level: 50,
		special_points: 0,
		perk_points: 0,
		// Sprites
		sprites: { idle: spr_lobotomite, attack: spr_lobotomite, dodge: spr_lobotomite, down: spr_lobotomite_downed, inventory: spr_lobotomite_white },
		// Actions
		actions: [
		// Basic attack
		global.action_library.attack, 
		// Abilities
		global.action_library.axe_cleave, 
		// Items
		global.action_library.stimpak, 
		global.action_library.doctors_bag, 
		global.action_library.nuka_cola, 
		global.action_library.battle_brew, 
		global.action_library.med_x
		// global.action_library.flee
		]
	}
	,
	{
		// Name
		name: "Cyberdog",
		is_player_unit: true,
		level: 1,
		// SPECIAL
		strength: 7,		// Power of melee attacks
		perception: 7,		// Power of ranged attacks
		endurance: 7,		// Base defense value
		charisma: 4,		// BET rate (and OOC bartering)
		intelligence: 2,	// Item effectiveness
		agility: 8,			// Turn order and AP rate per turn
		luck: 5,			// Crit rate
		// Stats
		hp: 50,
		hp_max: 108,
		ap: 10,
		ap_max: 10,
		bet: 0,
		bet_max: 100,
		attack_mult: 1,
		defense_mult: 1,
		xp_total: 0,
		xp_to_next_level: 50,
		special_points: 0,
		perk_points: 0,
		// Sprites
		sprites: { idle: spr_cyberdog, attack: spr_cyberdog, dodge: spr_cyberdog, down: spr_cyberdog_downed, inventory: spr_cyberdog_white },
		// Actions
		actions: [
		// Basic attack
		global.action_library.attack, 
		// Abilities
		global.action_library.sonic_bark, 
		// Items
		global.action_library.stimpak, 
		global.action_library.doctors_bag, 
		global.action_library.nuka_cola, 
		global.action_library.battle_brew, 
		global.action_library.med_x
		// global.action_library.flee
		]
	}
];

#macro PARTY_VAULTIE 0
#macro PARTY_LOBOTOMITE 1
#macro PARTY_CYBERDOG 2

// 'party' is the current player party
global.party = [global.party_data[0]];

// Enemy data
global.enemies =
{
	orderly_mk1:
	{
		// Name
		name: "Orderly",
		is_player_unit: false,
		// SPECIAL
		strength: 5,		// Power of melee attacks
		perception: 5,		// Power of ranged attacks
		endurance: 5,		// Base defense value
		charisma: 5,		// N/A
		intelligence: 5,	// Item effectiveness
		agility: 5,			// Turn order and AP rate per turn
		luck: 5,			// Crit rate
		// Stats
		hp: 50,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		bet: 0,
		bet_max: 0,
		attack_mult: 1,
		defense_mult: 1,
		xp_yield: 50,
		// Sprites
		sprites: { idle: spr_orderly, attack: spr_orderly},
		// Actions
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
		// Name
		name: "P.CybDog",
		is_player_unit: false,
		// SPECIAL
		strength: 5,		// Power of melee attacks
		perception: 5,		// Power of ranged attacks
		endurance: 5,		// Base defense value
		charisma: 5,		// N/A
		intelligence: 5,	// Item effectiveness
		agility: 5,			// Turn order and AP rate per turn
		luck: 5,			// Crit rate
		// Stats
		hp: 30,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		bet: 0,
		bet_max: 0,
		attack_mult: 1,
		defense_mult: 1,
		xp_yield: 50,
		// Sprites
		sprites: { idle: spr_cyberdog_enemy, attack: spr_cyberdog_enemy},
		// Actions
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
		// Name
		name: "Turret",
		is_player_unit: false,
		// SPECIAL
		strength: 5,		// Power of melee attacks
		perception: 5,		// Power of ranged attacks
		endurance: 5,		// Base defense value
		charisma: 5,		// N/A
		intelligence: 5,	// Item effectiveness
		agility: 5,			// Turn order and AP rate per turn
		luck: 5,			// Crit rate
		// Stats
		hp: 300,
		hp_max: 300,
		ap: 10,
		ap_max: 10,
		bet: 0,
		bet_max: 0,
		attack_mult: 1,
		defense_mult: 1,
		xp_yield: 50,
		// Sprites
		sprites: { idle: spr_turret_ceiling, attack: spr_turret_ceiling},
		// Actions
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
		// Name
		name: "Harness",
		is_player_unit: false,
		// SPECIAL
		strength: 5,		// Power of melee attacks
		perception: 5,		// Power of ranged attacks
		endurance: 5,		// Base defense value
		charisma: 5,		// N/A
		intelligence: 5,	// Item effectiveness
		agility: 5,			// Turn order and AP rate per turn
		luck: 5,			// Crit rate
		// Stats
		hp: 30,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		bet: 0,
		bet_max: 0,
		attack_mult: 1,
		defense_mult: 1,
		xp_yield: 50,
		// Sprites
		sprites: { idle: spr_traumaharness, attack: spr_traumaharness},
		// Actions
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

/// UI Colour
/// TODO: Could probably remake this system using a shader instead, but this'll work for now
global.ui_textbox		=	spr_textbox_orange;
global.ui_pointer		=	spr_pointer_orange;
global.ui_arrow_up		=	spr_arrow_up_orange;
global.ui_arrow_down	=	spr_arrow_down_orange;
global.ui_arrow_left	=	spr_arrow_left_orange;
global.ui_arrow_right	=	spr_arrow_right_orange;

/*
/// Misc stuff

// Skills
		skill_Barter: 100,
		skill_Energy_Weapons: 100,
		skill_Explosives: 100,
		skill_Guns: 100,
		skill_Lockpick: 100,
		skill_Medicine: 100,
		skill_Melee_Weapons: 100,
		skill_Repair: 100,
		skill_Science: 100,
		skill_Sneak: 100,
		skill_Speech: 100,
		skill_Survival: 100,
		skill_Unarmed: 100,
*/