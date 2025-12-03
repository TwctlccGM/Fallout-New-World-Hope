/// @description
// Save data to save file
	var _save_data = array_create(0); // Make save array
	for (var i = 0; i < array_length(global.party_data); i++) // Add party member data to the save array
	{
		var _save_entity =	// Make struct
		{
			party				:	global.party,							// Party setup
			saved_room			:	room,									// Room
			party_member		:	global.party_data[i].name,				// Name
			is_recruited		:	global.party_data[i].is_recruited,		// Recruited
			level				:	global.party_data[i].level,				// Level
			hp					:	global.party_data[i].hp,				// HP
			hp_max				:	global.party_data[i].hp_max,			// HP Max
			bet					:	global.party_data[i].bet,				// BET
			strength			:	global.party_data[i].strength,			// STR
			perception			:	global.party_data[i].perception,		// PER
			endurance			:	global.party_data[i].endurance,			// END
			charisma			:	global.party_data[i].charisma,			// CHA
			intelligence		:	global.party_data[i].intelligence,		// INT
			agility				:	global.party_data[i].agility,			// AGI
			luck				:	global.party_data[i].luck,				// LCK
			xp_total			:	global.party_data[i].xp_total,			// XP
			xp_to_next_level	:	global.party_data[i].xp_to_next_level,	// XP to next level
			special_points		:	global.party_data[i].special_points,	// SPECIAL points
			perk_points			:	global.party_data[i].perk_points,		// Perk points
			// TO-DO: Saving the item array per character is redundant but icba to optimise it rn.
			items				:	global.item_array
		}
		array_push(_save_data, _save_entity); // Add struct to save array
	}
	// Turn this data into a JSON string and save it via a buffer
	var _string = json_stringify(_save_data);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, "savedgame.save");
	buffer_delete(_buffer);
	
	show_debug_message("Game Saved! " + _string); // Debug message















