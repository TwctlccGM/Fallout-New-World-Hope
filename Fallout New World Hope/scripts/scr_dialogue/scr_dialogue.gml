function dialogue_responses() {
	// @arg Response
	// Yes all the dialogue is stored in this switch statement, it just works
	switch(argument0)
	{
		case 0: break;	// End of conversation
		
		case 1: new_text_box("The lobotomite is injured.\nHe'll need medical treatment.", DIALOGUE, 1, ["3:Use a Doctor's Bag", "2:Leave"]); break;
		
		case 2: new_text_box("There may be a doctor's bag somewhere\nin this medical facility."); break; 
		
		case 3: // Attempt to recruit lobotomite
		{
			// Heal him with a doctor's bag
			if (global.item_array[ITEM_DOCTORSBAG][C_ITEM_AMOUNT] > 0)
			{
				global.item_array[ITEM_DOCTORSBAG][C_ITEM_AMOUNT] -= 1;
				
				// Party full
				if (array_length(global.party) >= 2)
				{
					new_text_box("You healed the lobotomite.\nHe can now join the party!", DIALOGUE);
					global.party_data[PARTY_LOBOTOMITE].is_recruited = true;
				}
				// Party not full
				else
				{
					new_text_box("You healed the lobotomite.\nHe joined your party!", DIALOGUE);
					global.party_data[PARTY_LOBOTOMITE].is_recruited = true;
					array_insert(global.party, array_length(global.party), global.party_data[PARTY_LOBOTOMITE]);
				}
				instance_destroy();
			}
			else
			{
				new_text_box("You don't have a doctor's bag.", DIALOGUE);
			}
		} break;
		
		case 4: // Approach cyberdog, ambushed by enemy dogs
		{
			// Party full
			if (array_length(global.party) >= 2)
			{
				new_text_box("As you approach, you are ambushed!\nThe cyberdog fights alongside you!", DIALOGUE, 1, ["5:"]);
				global.party_data[PARTY_LOBOTOMITE].is_recruited = true;
				array_insert(global.party, 2, global.party_data[PARTY_CYBERDOG]); // Cyberdog replaces last party member
			}
			// Party not full
			else
			{
				new_text_box("As you approach, you are ambushed!\nThe cyberdog fights alongside you!", DIALOGUE, 1, ["5:"]);
				global.party_data[PARTY_LOBOTOMITE].is_recruited = true;
				array_insert(global.party, array_length(global.party), global.party_data[PARTY_CYBERDOG]);
			}
		} break;
		
		case 5: 
		{
			instance_destroy(obj_text);
			new_encounter([global.enemies.cyberdog_police, global.enemies.cyberdog_police], spr_background_boom_town_ph);
		} break;
		
		case 6: // Approach knight, ambushed by enemy lobotomites (TODO: Make enemy lobotomite approach player, then have the knight show up)
		{
			// Party full
			if (array_length(global.party) >= 2)
			{
				new_text_box("You are ambushed by enemy lobotomites!\nThe knight comes to your aid!", DIALOGUE, 1, ["7:"]);
				global.party_data[PARTY_LOBOTOMITE].is_recruited = true;
				array_insert(global.party, 2, global.party_data[PARTY_KNIGHT]); // Knight replaces last party member
			}
			// Party not full
			else
			{
				new_text_box("You are ambushed by enemy lobotomites!\nThe knight comes to your aid!", DIALOGUE, 1, ["7:"]);
				global.party_data[PARTY_LOBOTOMITE].is_recruited = true;
				array_insert(global.party, array_length(global.party), global.party_data[PARTY_KNIGHT]);
			}
		} break;
		
		case 7: 
		{
			instance_destroy(obj_text);
			new_encounter([global.enemies.lobotomite_rabid, global.enemies.lobotomite_rabid], spr_background_boom_town_ph);
		} break;
		
		default: show_debug_message("UNEXPECTED CONVERSATION END!"); break; // Unexpected end of conversation
	}
}

