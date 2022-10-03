;/ Decompiled by Champollion V1.0.1
Source   : PRKF_SQL_Mechanics_Perk_Vamp_0317696D.psc
Modified : 2021-05-01 23:00:04
Compiled : 2021-05-01 23:00:05
User     : maxim
Computer : CANOPUS
/;
scriptName PRKF_SQL_Mechanics_Perk_Vamp_0317696D extends Perk hidden

;-- Properties --------------------------------------
sql_feedmanager_script property FeedManager auto
spell property SQL_Mechanics_Spell_Feed_Aggro auto
actor property PlayerRef auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function Fragment_56(ObjectReference akTargetRef, actor akActor)

	FeedManager.ProcessFeed(akTargetRef as actor, true, true, true, true)
endFunction

function Fragment_0(ObjectReference akTargetRef, actor akActor)

	FeedManager.ProcessFeed(akTargetRef as actor, false, true, true, true)
endFunction

function Fragment_262(ObjectReference akTargetRef, actor akActor)

	SQL_Mechanics_Spell_Feed_Aggro.Cast(PlayerRef as ObjectReference, (akTargetRef as actor) as ObjectReference)
	FeedManager.ProcessFeed(akTargetRef as actor, true, false, true, true)
endFunction

function Fragment_268(ObjectReference akTargetRef, actor akActor)

	SQL_Mechanics_Spell_Feed_Aggro.Cast(PlayerRef as ObjectReference, (akTargetRef as actor) as ObjectReference)
	FeedManager.ProcessFeed(akTargetRef as actor, true, false, true, true)
endFunction

function Fragment_271(ObjectReference akTargetRef, actor akActor)

	SQL_Mechanics_Spell_Feed_Aggro.Cast(PlayerRef as ObjectReference, (akTargetRef as actor) as ObjectReference)
	FeedManager.ProcessFeed(akTargetRef as actor, true, false, true, false)
endFunction

function Fragment_2(ObjectReference akTargetRef, actor akActor)

	FeedManager.ProcessFeed(akTargetRef as actor, false, false, true, true)
endFunction

; Skipped compiler generated GotoState

function Fragment_58(ObjectReference akTargetRef, actor akActor)

	FeedManager.ProcessFeed(akTargetRef as actor, true, false, true, true)
endFunction

function Fragment_264(ObjectReference akTargetRef, actor akActor)

	SQL_Mechanics_Spell_Feed_Aggro.Cast(PlayerRef as ObjectReference, (akTargetRef as actor) as ObjectReference)
	FeedManager.ProcessFeed(akTargetRef as actor, false, false, true, true)
endFunction

; Skipped compiler generated GetState

function Fragment_266(ObjectReference akTargetRef, actor akActor)

	SQL_Mechanics_Spell_Feed_Aggro.Cast(PlayerRef as ObjectReference, (akTargetRef as actor) as ObjectReference)
	FeedManager.ProcessFeed(akTargetRef as actor, false, false, true, true)
endFunction

function Fragment_273(ObjectReference akTargetRef, actor akActor)

	SQL_Mechanics_Spell_Feed_Aggro.Cast(PlayerRef as ObjectReference, (akTargetRef as actor) as ObjectReference)
	FeedManager.ProcessFeed(akTargetRef as actor, false, false, true, false)
endFunction

function Fragment_228(ObjectReference akTargetRef, actor akActor)

	FeedManager.ProcessFeed(akTargetRef as actor, false, false, true, true)
endFunction
