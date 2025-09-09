/// @description
// Placeholder 'use stimpak' button
for (var _pos = 0; _pos < array_length(global.item_array); _pos++) // Scan array for if the item type is already in there
{
	if (global.item_array[_pos][C_ITEM_TYPE] == ITEM_STIMPAK && global.item_array[_pos][C_ITEM_AMOUNT] > 0)
	{ 
		var _heal = 100;
		battle_change_hp(global.party[0], _heal, 1, 0); // Heal target
		global.item_array[_pos][C_ITEM_AMOUNT] -= 1; // Remove stim
	}
}
// TO-DO: 
// - Make party stats visible outside of combat
// - Make party members selectable so you can choose who to heal
