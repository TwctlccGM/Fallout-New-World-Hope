/// @description
draw_set_font(fnt_monofonto);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

item_pos = 0;
item_pos_index = 0;

draw_inventory = false;

function use_stimpak(_target)
{
	for (var _pos = 0; _pos < array_length(global.item_array); _pos++) // Scan array for if the item type is already in there
	{
		if (global.item_array[_pos][C_ITEM_TYPE] == ITEM_STIMPAK && global.item_array[_pos][C_ITEM_AMOUNT] > 0)
		{ 
			var _heal = 100;
			battle_change_hp(global.party[_target], _heal, 1, 0); // Heal target
			global.item_array[_pos][C_ITEM_AMOUNT] -= 1; // Remove stim
		}
	}
}

// Make targeting cursor
cursor = 
{
	active_user: noone,
	active_target: noone,
	active_action: -1,
	target_side: -1,
	target_index: 0,
	target_all: false,
	confirm_delay: 0,
	active: false
};

party = [];
// Make party
for (var i = 0; i < array_length(global.party); i++)
{
	// TO-DO: Replace magic numbers here
	party_units[i] = instance_create_depth(x + 70 + (i * 10), y + 68 + (i * 15), depth + 10, obj_battle_units_player, global.party[i]);
	array_push(party, party_units[i]);
}
