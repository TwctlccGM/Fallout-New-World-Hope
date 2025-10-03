/*
/// BUGS AND STUFF TO FIX

- Items (stims and doc bags) get consumed even when they have no effect.
- Items not in player's inventory appear in battle (but at least they are greyed out and unusable)
- Fix up battle menu a bit (make options appear in order: Attack -> Abilities -> Items -> Flee)
- Pointer in inventory menu sometimes goes up too far when selecting an item (idk what triggers this to start happening)

/// FEATURES TO IMPLEMENT

- Keys/Keycards to unlock doors.
- Dialogue system.
- BET system in combat

/// Notes
Adding/Removing party members:
	The player's current party is stored as an array of structs 'global.party' in scr_game_data.
	The information of all party members is stored as an array of structs 'global.party_data' in scr_game data.
	To add a party member to the array, use this function: 'array_insert(global.party, array_length(global.party), global.party_data[PARTY_CYBERDOG]);'
	It inserts the party member data from 'party_data' into the current 'party' (replace 'CYBERDOG' with the appropriate macro).

*/