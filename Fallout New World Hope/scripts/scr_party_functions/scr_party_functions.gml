function is_in_party(_member) {
/// @function is_in_party(_member)
/// @param member - The struct of the party member to be checked
/// @return true if the member is in the active party
    for (var i = 0; i < array_length(global.party); i++) {
        if (global.party[i] == _member) {
            return true;
        }
    }
    return false;
}