;/* VampireFeedProxyInner
* * inner part of the vampire feed proxy, handles overhaul specific functions
*/;
ScriptName VampireFeedProxyInner

;/* CanFeedOn
* * checks if the given actor can feed on the given target
* *
* * @param: akFeeder, the actor who is supposed to feed
* * @param: akTarget, the actor who gets fed upon
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
* * @param akTarget, the actor who was fed on
* * @param abIsLethal, if True the target dies to this action
*/;
Function VampireFeed(Actor akTarget, bool abIsLethal) Global
	(Game.GetFormFromFile(0x000FAB6F, "Sacrosanct - Vampires of Skyrim.esp") As scs_feedmanager_quest).ProcessFeedInner(akTarget, abIsLethal, akTarget && akTarget.GetSleepState() == 3, False, False, False, False, False)
EndFunction

;/* NpcVampireFeed
* * triggers the vampire feed effect as if an npc fed on another npc
* * most overhauls don't do anything here
* *
* * @param: akFeeder, the actor who did the feeding
* * @param: akTarget, the actor who was fed on
* * @param: abIsLethal, if True the target dies to this action
*/;
Function NpcVampireFeed(Actor akFeeder, Actor akTarget, bool abIsLethal) Global
	If akTarget && abIsLethal
		akTarget.Kill(akFeeder)
	EndIf
EndFunction