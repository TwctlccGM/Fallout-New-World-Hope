/// @description
// Deactivate field objects
instance_deactivate_all(true);

units = [];

// Make enemies
for (var _i = 0; _i < array_length(enemies); _i++)
{
	// TO-DO: Replace magic numbers here
	enemy_units[_i] = instance_create_depth(x + 250 + (_i * 10), y + 68 + (_i * 20), depth - 10, obj_battle_units_enemy, enemies[_i]);
	array_push(units, enemy_units[_i]);
}

// Make party
for (var _i = 0; _i < array_length(global.party); _i++)
{
	// TO-DO: Replace magic numbers here
	party_units[_i] = instance_create_depth(x + 70 + (_i * 10), y + 68 + (_i * 15), depth - 10, obj_battle_units_player, global.party[_i]);
	array_push(units, party_units[_i]);
}