/*
/// BUGS AND STUFF TO FIX

1: Two or more actions can't be a part of the same combat submenu (e.g. can't have two abilities in the 'Abilities' menu)
2: Items (stims and doc bags) get consumed even when they have no effect.
3: Turn repeated code (e.g. item pickups) into a function for easier usage and reading.
4: Items used in battle that have not yet been added to the inventory array crash the game.

/// FEATURES TO IMPLEMENT

1: Ability to add/remove party members in-game.
2: Keys/Keycards to unlock doors.
3: Dialogue system.
4: More scalable item system (right now each item is just a duplicate of the stimpak code with a different function used)
	- Maybe implement a better 'item' variable so that the item id in the item array doesn't need to be checked so much
5: More items (Battle Brew, Med-X, Keycards)

*/