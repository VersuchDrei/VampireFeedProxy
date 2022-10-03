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
	; target not a vampire
	Return !akTarget.HasKeyword(Game.GetFormFromFile(0x000a82bb, "Skyrim.esm") As Keyword)
EndFunction

;/* VampireFeed
* * triggers the vampire feed effect as if the player has fed on the given actor
* * 
* * @param: akTarget, the actor who was fed on
* * @param: abIsLethal, if True the victim dies due to this action
* * 	do not set this to true for actors that already are dead as some overhauls call the kill function themselves
*/;
Function VampireFeed(Actor akTarget = None, bool abIsLethal = False) Global
	(Game.GetFormFromFile(0x000eafd5, "Skyrim.esm") As PlayerVampireQuestScript).VampireFeed()
	
	If abIsLethal
		akTarget.Kill(Game.GetPlayer())
	EndIf
EndFunction