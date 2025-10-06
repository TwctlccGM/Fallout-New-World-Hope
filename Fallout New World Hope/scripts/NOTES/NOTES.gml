/*
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// THINGS TO FIX

	- Items (stims and doc bags) get consumed even when they have no effect.
	- Items not in player's inventory appear in battle (but at least they are greyed out and unusable)
	- Fix up battle menu a bit (make options appear in order: Attack -> Abilities -> Items -> Flee)
	- Pointer in inventory menu sometimes goes up too far when selecting an item (idk what triggers this to start happening)
	- Make abilities/bets greyed out and unselectable when not enough AP/BET to use them (atm they are 'failed' in obj_battle Create event)
	

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// FEATURES TO IMPLEMENT

	- Keys/Keycards to unlock doors.
		Make individual keycards (e.g. X-8 keycard to open X-8 door)
	- Dialogue system.
	- BET system in combat.
	- More items (don't add all of these, just pick what's best)
		Super Stimpak	(stronger stim)
		Auto-Stim		(auto heals when below 50% health)
		Auto-SuperStim	(auto heals when below 25% health)
			Maybe make the auto-stims a Vaultie ability?
		Stealth Boy		(become untargetable)
		Mentats			(increase BET)
		Turbo			(move twice)
		Hydra			(heal over time)
		Rebound			(+2AP regen per turn instead of +1)
		Steady			(Improved accuracy)
			Implement accuracy system first
		Antivenom		(Cures cazador/nightstalker poison)
		


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// NOTES

Adding/Removing party members:
	The player's current party is stored as an array of structs 'global.party' in scr_game_data.
	The information of all party members is stored as an array of structs 'global.party_data' in scr_game data.
	To add a party member to the array, use this function: 'array_insert(global.party, array_length(global.party), global.party_data[PARTY_CYBERDOG]);'
	It inserts the party member data from 'party_data' into the current 'party' (replace 'CYBERDOG' with the appropriate macro).

Changing UI colour:
	Right now there are 3 sets of sprites for different UI colours (orange, green, blue).
	The UI colour is set manually at the bottom of scr_game_data. Cannot be changed in-game atm.
	Should change this system to use a shader so that there's no need for repeat sprites and so many global UI variables (just one global UI colour shader variable).


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/