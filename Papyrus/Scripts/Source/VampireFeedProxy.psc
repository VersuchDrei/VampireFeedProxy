;/* VampireFeedProxy
* * outter part of the vampire feed proxy, this is the same no matter which overhaul is used
*/;
ScriptName VampireFeedProxy

;/* SendFeedEvent
* * SKSE Plugin function to send the OnVampireFeed event to the actor and its reference aliases and active magic effects
* *
* * @param: akFeeder, the actor to send the event to
* * @param akTarget, the Actor parameter of the event
*/;
Function SendFeedEvent(Actor akFeeder, Actor akTarget) Global Native

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
	Return VampireFeedProxyInner.CanFeedOn(akFeeder, akTarget)
EndFunction

;/* VampireFeed
* * triggers the vampire feed effect as if the player has fed on the given actor
* * 
* * @param: akTarget, the actor who was fed on
* * @param: abIsLethal, if True the target dies to this action
* * 	do not set this to true for actors who already are dead as some overhauls call the kill function themselves
*/;
Function VampireFeed(Actor akTarget = None, bool abIsLethal = False) Global
	If akTarget
		SendFeedEvent(Game.GetPlayer(), akTarget)
	EndIf

	VampireFeedProxyInner.VampireFeed(akTarget, abIsLethal)
EndFunction

;/* NpcVampireFeed
* * sends mod events for NPC on NPC feeding so that other mods can react to that
* *
* * @param: akFeeder, the actor who did the feeding
* * @param: akTarget, the actor who was fed on
* * @param: abIsLethal, if True the target dies to this action
*/;
Function NpcVampireFeed(Actor akFeeder, Actor akTarget = None, bool abIsLethal = False) Global
	If akTarget
		SendFeedEvent(akFeeder, akTarget)
	EndIf

	int Lethal = 0
	If abIsLethal
		Lethal = 1
	EndIf

	; when listening to this event:
	; Form sender will be the feeding actor
	; string strArg will be the form id of the target actor (I wish I could pass the actor here, but mod events are limited)
	; float numArg will indicate if the feeding was lethal (0 = non lethal, 1 = lethal)
	akFeeder.SendModEvent("NpcVampireFeed", akTarget.GetFormId(), lethal)

	VampireFeedProxyInner.NpcVampireFeed(akFeeder, akTarget, abIsLethal)
EndFunction

;/* AnyVampireFeed
* * convenience function to trigger either player or npc feeding depending on if akFeeder is the player
* * so mod authors don't have to check for this in their scripts if both feed the same way
* *
* * @param: akFeeder, the actor who did the feeding
* * @param: akTarget, the actor who was fed on
* * @param: abIsLethal, if True the target dies to this action
* * 	do not set this to true for actors who already are dead as some overhauls call the kill function themselves
*/;
Function AnyVampireFeed(Actor akFeeder, Actor akTarget = None, bool abIsLethal = False) Global
	If akFeeder == Game.GetPlayer()
		VampireFeed(akTarget, abIsLethal)
	Else
		NpcVampireFeed(akFeeder, akTarget, abIsLethal)
	EndIf
EndFunction