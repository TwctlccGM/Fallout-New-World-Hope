function dialogue_responses() {
	// @arg Response
	// Yes all the dialogue is stored in this switch statement, it just works
	switch(argument0)
	{
		case 0: break;	// End of conversation
		case 1: new_text_box("The lobotomite is injured.\nHe'll need medical treatment.", DIALOGUE, 1, ["3:Use a Doctor's Bag", "2:Leave"]); break;
		case 2: new_text_box("There may be a doctor's bag somewhere\nin this medical facility."); break; 
		case 3: // Attempt to recruit cyberdog
		{
			// Heal him with a doctor's bag
			if (global.item_array[ITEM_DOCTORSBAG][C_ITEM_AMOUNT] > 0)
			{
				global.item_array[ITEM_DOCTORSBAG][C_ITEM_AMOUNT] -= 1;
				new_text_box("You healed the lobotomite.\nHe joined your party!", DIALOGUE);
				array_insert(global.party, array_length(global.party), global.party_data[PARTY_LOBOTOMITE]);
				instance_destroy();
			}
			else
			{
				new_text_box("You don't have a doctor's bag.", DIALOGUE);
			}
		}
		break;
		default: show_debug_message("UNEXPECTED CONVERSATION END!"); break; // Unexpected end of conversation
	}
}

