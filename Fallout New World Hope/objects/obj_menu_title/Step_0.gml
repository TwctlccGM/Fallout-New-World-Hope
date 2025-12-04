/// @description
		
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
		if (confirm_delay > 2)
		{
			_key_confirm = keyboard_check_pressed(ord("Z"));
			_key_cancel = keyboard_check_pressed(ord("X"));
			_key_toggle = keyboard_check_pressed(vk_shift);
		}
		var _move_v = _key_down - _key_up;

		// Move between targets
		if (_move_v == 1) target_index++;
		if (_move_v == -1) target_index--;
		
		if (obj_menu_title.title_menu_selected)
		{
			// Wrap
			var _targets = array_length(obj_menu_title.title_menu_options);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
		
			// Confirm action
			if (_key_confirm)
			{
				switch target_index
				{
					case NEW_GAME:
						/// 'New Game' save file
						// Default party data
						global.party_data =
						[
							{
								// Name
								name: "Vaultie",
								party_name: PARTY_VAULTIE,
								is_player_unit: true,
								is_recruited: true,
								level: 1,
								// SPECIAL
								strength: 4,		// Power of melee attacks
								perception: 6,		// Power of ranged attacks
								endurance: 3,		// Base defense value
								charisma: 10,		// BET rate (and OOC bartering)
								intelligence: 7,	// Item effectiveness
								agility: 6,			// Turn order and AP rate per turn (0 = 0 AP,  1-3 = 1 AP,  4-6 = 2 AP,  7-9 = 3 AP, 10 = 4 AP)
								luck: 10,			// Crit rate
								// Stats
								hp: 100 + (5 * 3 /*endurance*/ * 1 /*level*/),
								hp_max: 100 + (5 * 3 /*endurance*/ * 1 /*level*/),
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
								party_name: PARTY_LOBOTOMITE,
								is_player_unit: true,
								is_recruited: false,
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
								hp: 100 + (5 * 9 /*endurance*/ * 1 /*level*/),
								hp_max: 100 + (5 * 9 /*endurance*/ * 1 /*level*/),
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
								// Bet
								global.action_library.axe_throw,
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
								party_name: PARTY_CYBERDOG,
								is_player_unit: true,
								is_recruited: false,
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
								hp: 100 + (5 * 7 /*endurance*/ * 1 /*level*/),
								hp_max: 100 + (5 * 7 /*endurance*/ * 1 /*level*/),
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
								// Bet
								global.action_library.sonjaculate, 
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
								name: "Knight",
								party_name: PARTY_KNIGHT,
								is_player_unit: true,
								is_recruited: false,
								level: 1,
								// SPECIAL
								strength: 7,		// Power of melee attacks
								perception: 8,		// Power of ranged attacks
								endurance: 8,		// Base defense value
								charisma: 4,		// BET rate (and OOC bartering)
								intelligence: 5,	// Item effectiveness
								agility: 4,			// Turn order and AP rate per turn
								luck: 4,			// Crit rate
								// Stats
								hp: 100 + (5 * 8 /*endurance*/ * 1 /*level*/),
								hp_max: 100 + (5 * 8 /*endurance*/ * 1 /*level*/),
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
								sprites: { idle: spr_knight, attack: spr_knight, dodge: spr_knight, down: spr_knight, inventory: spr_knight_white },
								// Actions
								actions: [
								// Basic attack
								global.action_library.attack, 
								// Abilities
								global.action_library.barrage, 
								// Bet
								global.action_library.overcharge,
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
					
						// Reset party
						global.party = [global.party_data[0]];
					
						// Reset items
						for (var i = 0; i < array_length(global.item_array); i++) // Loop for each item
							{
								global.item_array[i][3] = 0;
							}
						room_goto(rm_field_y17);
						break;
					
					case LOAD_GAME:
						if (file_exists("savedgame.save")) // Check if there's a save file
						{
							var _buffer = buffer_load("savedgame.save"); // Read from the save file using a buffer
							var _string = buffer_read(_buffer, buffer_string);
							buffer_delete(_buffer);
	
							var _load_data = json_parse(_string); // Turn JSON data into an array of player unit stats
							var _reversed_load_data = array_reverse(_load_data); // Reverse the array to assign stats in correct order
							var _saved_room = rm_overworld;
							// Edit the global.party_data using saved data
							for (var i = 0; i < array_length(global.party_data); i++) // Loop for each party member
							{
								var _load_entity = array_pop(_reversed_load_data); // Take data from the save data array, then delete it from the array
													global.party		= _load_entity.party;				// Party setup
													_saved_room			= _load_entity.saved_room;			// Room
								global.party_data[i].level				= _load_entity.level;				// Level
								global.party_data[i].is_recruited		= _load_entity.is_recruited;		// Recruited
								global.party_data[i].hp					= _load_entity.hp;					// HP
								global.party_data[i].hp_max				= _load_entity.hp_max;				// HP Max
								global.party_data[i].bet				= _load_entity.bet;					// BET
								global.party_data[i].strength			= _load_entity.strength;			// STR
								global.party_data[i].perception			= _load_entity.perception;			// PER
								global.party_data[i].endurance			= _load_entity.endurance;			// END
								global.party_data[i].charisma			= _load_entity.charisma;			// CHA
								global.party_data[i].intelligence		= _load_entity.intelligence;		// INT
								global.party_data[i].agility			= _load_entity.agility;				// AGI
								global.party_data[i].luck				= _load_entity.luck;				// LCK
								global.party_data[i].xp_total			= _load_entity.xp_total;			// XP
								global.party_data[i].xp_to_next_level	= _load_entity.xp_to_next_level	;	// XP to next level
								global.party_data[i].special_points		= _load_entity.special_points;		// SPECIAL points
								global.party_data[i].perk_points		= _load_entity.perk_points;			// Perk points
								// TO-DO: Item array gets loaded for every party member. This is inefficient, it only needs to be loaded once but icba rn.
								global.item_array						= _load_entity.items;				// Items
							}
							room_goto(_saved_room);
						}
						else
						{
							show_debug_message("Load failed, save file doesn't exist");
						}
						break;
					case OPTIONS:
						// Go to Options menu
						obj_menu_title.options_menu_selected = true;
						obj_menu_title.title_menu_selected = false;
						target_index = 0;
						confirm_delay = 0;
						break;
					case QUIT:
						game_end();
						break;
					default:
						show_debug_message("Title menu switch statement error");
				}
			}
		}
		
		else if (obj_menu_title.options_menu_selected)
		{
			// Wrap
			var _targets = array_length(obj_menu_title.options_menu_options);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
		
			// Confirm action
			if (_key_confirm)
			{
				switch target_index
				{
					case UI_COLOUR:
						// Go to Colour menu
						obj_menu_title.colour_menu_selected = true;
						obj_menu_title.options_menu_selected = false;
						target_index = 0;
						confirm_delay = 0;
						break;
					case BACK1:
						// Go to Title menu
						obj_menu_title.title_menu_selected = true;
						obj_menu_title.options_menu_selected = false;
						target_index = 0;
						confirm_delay = 0;
						break;
					default:
						show_debug_message("Options menu switch statement error");
				}
			}
			
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				// Go to title menu
				obj_menu_title.title_menu_selected = true;
				obj_menu_title.options_menu_selected = false;
				target_index = 0;
				confirm_delay = 0;
			}
		}
		
		else if (obj_menu_title.colour_menu_selected)
		{
			// Wrap
			var _targets = array_length(obj_menu_title.colour_menu_options);
			if (target_index < 0) target_index = _targets - 1;
			if (target_index > (_targets - 1)) target_index = 0;
		
			// Confirm action
			if (_key_confirm)
			{
				switch target_index
				{
					case ORANGE:
						// Set UI to orange
						/// TODO: Could probably remake this system using a shader instead, but this'll work for now
						global.ui_textbox		=	spr_textbox_orange;
						global.ui_pointer		=	spr_pointer_orange;
						global.ui_arrow_up		=	spr_arrow_up_orange;
						global.ui_arrow_down	=	spr_arrow_down_orange;
						global.ui_arrow_left	=	spr_arrow_left_orange;
						global.ui_arrow_right	=	spr_arrow_right_orange;
						break;
					case BLUE:
						// Set UI to blue
						/// TODO: Could probably remake this system using a shader instead, but this'll work for now
						global.ui_textbox		=	spr_textbox_blue;
						global.ui_pointer		=	spr_pointer_blue;
						global.ui_arrow_up		=	spr_arrow_up_blue;
						global.ui_arrow_down	=	spr_arrow_down_blue;
						global.ui_arrow_left	=	spr_arrow_left_blue;
						global.ui_arrow_right	=	spr_arrow_right_blue;
						break;
					case GREEN:
						// Set UI to blue
						/// TODO: Could probably remake this system using a shader instead, but this'll work for now
						global.ui_textbox		=	spr_textbox_green;
						global.ui_pointer		=	spr_pointer_green;
						global.ui_arrow_up		=	spr_arrow_up_green;
						global.ui_arrow_down	=	spr_arrow_down_green;
						global.ui_arrow_left	=	spr_arrow_left_green;
						global.ui_arrow_right	=	spr_arrow_right_green;
						break;
					case BACK2:
						// Go to Title menu
						obj_menu_title.options_menu_selected = true;
						obj_menu_title.colour_menu_selected = false;
						target_index = 0;
						confirm_delay = 0;
						break;
					default:
						show_debug_message("Colour menu switch statement error");
				}
			}
			
			// Cancel & return to menu
			if (_key_cancel) && (!_key_confirm)
			{
				// Go to title menu
				obj_menu_title.options_menu_selected = true;
				obj_menu_title.colour_menu_selected = false;
				target_index = 0;
				confirm_delay = 0;
			}
		}
	}
}














