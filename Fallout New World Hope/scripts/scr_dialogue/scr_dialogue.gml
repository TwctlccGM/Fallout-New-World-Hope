function dialogue_responses() {
	// @arg Response
	// Yes... all the dialogue is stored in this switch statement, it just works
	switch(argument0)
	{
		case 0: break;	// End of conversation
		case 1: new_text_box("The dog looks injured.\nHeal him?", 1, ["3:Yes", "2:No"]); break;
		case 2: new_text_box("You backed away from the dog.", 1); break; 
		case 3: // Recruit cyberdog
		{
			new_text_box("You healed the dog.\nIt joined your party!", 0);
			array_insert(global.party, array_length(global.party), global.party_data[PARTY_CYBERDOG]);
			instance_destroy();
		}
		break;
		default: show_debug_message("UNEXPECTED CONVERSATION END!"); break; // Unexpected end of conversation
	}
}

