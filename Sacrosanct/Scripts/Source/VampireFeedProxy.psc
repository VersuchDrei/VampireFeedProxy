ScriptName VampireFeedProxy

;/* CanFeedOn
* * checks if the given actor can feed on the given target
* *
* * @param: akFeeder, the actor that is supposed to feed
* * @param: akTarget, the actor that gets fed upon
* * 
* * @return: True if feeding is possible
*/;
bool Function CanFeedOn(Actor akFeeder, Actor akTarget) Global
	; target not vampire or feeder has amaranth
	Return !akTarget.HasKeyword(Game.GetFormFromFile(0x000a82bb, "Skyrim.esm") As Keyword) || \
		akFeeder.HasPerk(Game.GetFormFromFile(0x000524a0, "Sacrosanct - Vampires of Skyrim.esp") As Perk)
EndFunction

;/* VampireFeed
* * triggers the vampire feed effect as if the player has fed on the given actor
* * 
* * @param: akTarget, the actor who was fed on
* * @param: abIsLethal, if True the victim dies due to this action
* * 	do not set this to true for actors that already are dead as some overhauls call the kill function themselves
*/;
Function VampireFeed(Actor akTarget = None, bool abIsLethal = False) Global
	(Game.GetFormFromFile(0x000FAB6F, "Sacrosanct - Vampires of Skyrim.esp") As scs_feedmanager_quest).ProcessFeedInner(akTarget, abIsLethal, akTarget && akTarget.GetSleepState() == 3, False, False, False, False, False)
EndFunction