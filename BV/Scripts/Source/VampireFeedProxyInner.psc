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
	; target not vampire or player has amaranth and target is not turned by player
	Return !akTarget.HasKeyword(Game.GetFormFromFile(0x000a82bb, "Skyrim.esm") As Keyword) || \
		akFeeder == Game.GetPlayer() && \
		(Game.GetFormFromFile(0x0003713c, "Better Vampires.esp") As GlobalVariable).GetValue() >= 60000 && \
		akTarget.HasKeyword(Game.GetFormFromFile(0x0054dcf7, "Better Vampires.esp") As Keyword) && \
		akTarget.GetAV("Variable08") != 9; and whatever BV uses this for...
EndFunction

;/* VampireFeed
* * triggers the vampire feed effect as if the player has fed on the given actor
* *
* * @param akTarget, the actor who was fed on
* * @param abIsLethal, if True the target dies to this action
*/;
Function VampireFeed(Actor akTarget, bool abIsLethal) Global
	If akTarget == None
		akTarget = Game.GetPlayer()
	EndIf

	(Game.GetFormFromFile(0x000eafd5, "Skyrim.esm") As PlayerVampireQuestScript).VampireFeed(akTarget)
	
	If abIsLethal && !akTarget.IsDead()
		akTarget.Kill(Game.GetPlayer())
	EndIf
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
	akFeeder.SetAV("Variable01", 0)

	If akTarget && abIsLethal
		akTarget.Kill(akFeeder)
	EndIf
EndFunction