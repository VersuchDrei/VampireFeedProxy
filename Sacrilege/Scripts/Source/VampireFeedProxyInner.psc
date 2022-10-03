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
	; target not a vampire
	Return !akTarget.HasKeyword(Game.GetFormFromFile(0x000a82bb, "Skyrim.esm") As Keyword)
EndFunction

;/* VampireFeed
* * triggers the vampire feed effect as if the player has fed on the given actor
* *
* * @param akTarget, the actor who was fed on
* * @param abIsLethal, if True the target dies to this action
*/;
Function VampireFeed(Actor akTarget, bool abIsLethal) Global
	(Game.GetFormFromFile(0x00176970, "Sacrilege - Minimalistic Vampires of Skyrim.esp") As SQL_FeedManager_Script).ProcessFeed(akTarget, abIsLethal, akTarget && akTarget.GetSleepState() == 3, False, False)
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