scriptName SCS_FeedManager_Quest extends Quest

;-- Properties --------------------------------------
message property SCS_Help_GetHemomancyByFeeding auto
globalvariable property SCS_Mechanics_Global_ForceUniqueCheck auto
formlist property SCS_Mechanics_FormList_HemomancyExpanded auto
spell property SCS_Abilities_Racial_Spell_Altmer_Proc auto
spell property SCS_Abilities_Racial_Spell_OrcNew_Proc_Long auto
message property DLC1BloodPointsMsg auto
spell property SCS_Abilities_Reward_Spell_BloodBond_Ab auto
playervampirequestscript property PlayerVampireQuest auto
globalvariable property SCS_VampireSpells_Vanilla_Power_Message_CanLamaesWrath auto
sound property SCS_Mechanics_Marker_FeedSound auto
potion property DLC1BloodPotion auto
spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2 auto
spell property SCS_Mechanics_Spell_FeedEmbrace_Target auto
String property SCS_Stat1 auto
spell property SCS_VampireSpells_Vanilla_Power_Spell_BloodIsPower auto
globalvariable property SCS_VampireSpells_VampireLord_Global_XP_LethalFeed_Level auto
spell property SCS_Abilities_Racial_Spell_Altmer_Proc_Long auto
scs_futil_script property SCS_Main500_Quest auto
globalvariable property SCS_VampireSpells_Hemomancy_Global_Stage_Steps auto
faction property PotentialMarriageFaction auto
globalvariable property DLC1VampireTotalPerksEarned auto
idle property IdleSearchBody auto
globalvariable property SCS_VampireSpells_Hemomancy_Global_Stage_StepsToNext_AddPerStep auto
globalvariable property SCS_Mechanics_Global_Age_BonusFromFeed auto
spell property SCS_Mechanics_Spell_Amaranth auto
globalvariable property SCS_Mechanics_Global_BlockFeed auto
formlist property SCS_Mechanics_FormList_StrongBlood auto
faction property PotentialFollowerFaction auto
idle property pa_HugA auto
message property SCS_Mechanics_Message_VampireFeed_Failed_PathObstructed auto
perk property SCS_LethalFeedXP auto
spell property SCS_Abilities_Racial_Spell_OrcNew_Proc auto
magiceffect property SCS_Abilities_Vanilla_Effect_Ab_ReverseProgression_Stage3 auto
perk property SCS_Mechanics_Perk_Amaranth auto
globalvariable property SCS_Mechanics_Global_Wassail_Current auto
actor property PlayerRef auto
spell property SCS_Mechanics_Spell_Amaranth_Target auto
magiceffect property SCS_Abilities_Racial_Effect_Dunmer_Ab auto
message property SCS_Help_CantFeedOnEssential auto
spell property SCS_Mechanics_Spell_SneakFeed_Target auto
message property SCS_Mechanics_Message_ScriptsBroken auto
message property SCS_Help_StrongBlood auto
globalvariable property DLC1VampireMaxPerks auto
spell property SCS_Abilities_Mechanics_Spell_Ab_AddRemoveHemomancySpells auto
dlc1vampireturnscript property DLC1VampireTurn auto
dlc1playervampirechangescript property DLC1PlayerVampireQuest auto
faction property CurrentFollowerFaction auto
spell property SCS_Mechanics_Spell_PsychicVampire_Target auto
globalvariable property SCS_VampireSpells_Hemomancy_Global_Stage_StepsToNext auto
spell property SCS_Abilities_Racial_Spell_Dunmer_Spell auto
globalvariable property DLC1VampireBloodPoints auto
globalvariable property SCS_VampireSpells_VampireLord_Global_XP_LethalFeed_Base auto
idle property IdleVampireStandingFront auto
message property SCS_Mechanics_Message_VampireFeed_Failed_Essential auto
spell property SCS_Mechanics_Spell_Feed_Target auto
message property SCS_Mechanics_Message_BloodBond auto
message property SCS_Mechanics_Message_StrongBlood auto
spell[] property SCS_Spell auto
globalvariable property DLC1VampireNextPerk auto
String property SCS_Stat0 auto
spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc auto
globalvariable property SCS_Mechanics_Global_Wassail_NerfAmount auto
globalvariable property SCS_VampireSpells_Hemomancy_Global_Stage auto
String property SCS_Stat2 auto
globalvariable property SCS_Mechanics_Global_Age_BonusFromDrain auto
globalvariable property DLC1VampirePerkPoints auto
spell property SCS_Mechanics_Spell_SeductionFeed_Target auto
magiceffect property SCS_Abilities_Racial_Effect_Orc_Ab auto
perk property SCS_PsychicVampire_Perk auto
keyword property Vampire auto
globalvariable property SCS_Mechanics_Global_BloodKnight_Cost auto
spell property SCS_Abilities_Reward_Spell_HarvestMoon_Ab auto
message property SCS_Mechanics_Message_HemomancyStageUp auto
formlist property SCS_Mechanics_FormList_StrongBlood_Track auto
globalvariable property SCS_Mechanics_Global_KissOfDeath_Amount auto
magiceffect property SCS_Abilities_Racial_Effect_Altmer_Ab auto
Quest property SCS_Sommelier_Quest auto
message property DLC1VampirePerkEarned auto
globalvariable property SCS_Mechanics_Global_DisableScriptsBroken auto

;-- Variables ---------------------------------------
Int StrongBloodCounter = 0

;-- Functions ---------------------------------------

Function ProcessFeed(actor akTarget, Bool akIsLethal, Bool akIsSleeping, Bool akIsSneakFeed, Bool akIsParalyzed, Bool akIsCombatFeed, Bool akIsEmbrace)
	ProcessFeedInner(akTarget, akIsLethal, akIsSleeping, akIsSneakFeed, akIsParalyzed, akIsCombatFeed, akIsEmbrace, True)
EndFunction

Function ProcessFeedInner(actor akTarget, Bool akIsLethal, Bool akIsSleeping, Bool akIsSneakFeed, Bool akIsParalyzed, Bool akIsCombatFeed, Bool akIsEmbrace, bool abVanillaAnimation)
	If akIsLethal && akTarget.IsEssential()
		SCS_Help_CantFeedOnEssential.ShowAsHelpMessage("SCS_CantFeedOnEssentialEvent", 5.00000, 0, 1)
		SCS_Mechanics_Message_VampireFeed_Failed_Essential.Show()
		Return 
	endIf

	If Self.GetStage() < 10
		Self.SetStage(10)
	EndIf

	debug.Trace("SACROSANCT DEBUG: Player feeds on target " + akTarget as String + ": Lethal " + akIsLethal + "; Sleeping " + akIsSleeping as String + "; Sneaking " + akIsSneakFeed, 0)
	
	If akTarget
		DLC1VampireTurn.PlayerBitesMe(akTarget)
		if akIsCombatFeed || akIsParalyzed
			akTarget.SetRestrained(true)
		endIf
	EndIf

	If abVanillaAnimation
		PlayerRef.StartVampireFeed(akTarget)
	EndIf

	If akTarget
		SCS_Mechanics_Marker_FeedSound.Play(akTarget)
		SCS_Mechanics_Spell_Feed_Target.Cast(PlayerRef, akTarget)
		If akIsLethal && akTarget.HasKeyword(Vampire)
			SCS_Mechanics_Spell_Amaranth.Cast(PlayerRef)
			SCS_Mechanics_Spell_Amaranth_Target.Cast(PlayerRef, akTarget)
		EndIf
	EndIf

	PlayerVampireQuest.VampireFeed()

	if PlayerRef.HasMagicEffect(SCS_Abilities_Racial_Effect_Dunmer_Ab)
		If akTarget
			SCS_Abilities_Racial_Spell_Dunmer_Spell.Cast(PlayerRef, akTarget)
		EndIf
	ElseIf PlayerRef.HasMagicEffect(SCS_Abilities_Racial_Effect_Altmer_Ab)
		If akIsSleeping
			SCS_Abilities_Racial_Spell_Altmer_Proc_Long.Cast(PlayerRef)
		Else
			SCS_Abilities_Racial_Spell_Altmer_Proc.Cast(PlayerRef)
		EndIf
	ElseIf PlayerRef.HasMagicEffect(SCS_Abilities_Racial_Effect_Orc_Ab)
		If akIsSleeping
			SCS_Abilities_Racial_Spell_OrcNew_Proc_Long.Cast(PlayerRef)
		Else
			SCS_Abilities_Racial_Spell_OrcNew_Proc.Cast(PlayerRef)
		EndIf
	EndIf

	if akIsSneakFeed
		akTarget.SendAssaultAlarm()
		SCS_Mechanics_Spell_SneakFeed_Target.Cast(PlayerRef, akTarget)
	endIf
	if akIsLethal
		akTarget.Kill(PlayerRef)
		game.AdvanceSkill("Destruction", SCS_VampireSpells_VampireLord_Global_XP_LethalFeed_Base.GetValue() + akTarget.GetLevel() * SCS_VampireSpells_VampireLord_Global_XP_LethalFeed_Level.GetValue())
	endIf
	if akIsParalyzed || akIsCombatFeed
		utility.Wait(1)
		akTarget.SetRestrained(false)
		game.EnablePlayerControls(true, true, true, true, true, true, true, true, 0)
		game.SetPlayerAIDriven(false)
	endIf
	if akIsCombatFeed
		PlayerRef.DamageActorValue("Stamina", SCS_Mechanics_Global_BloodKnight_Cost.GetValue())
	endIf
	if akIsSleeping && akIsLethal && PlayerRef.HasSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2 as form)
		PlayerRef.ModActorValue("Magicka", SCS_Mechanics_Global_KissOfDeath_Amount.value)
		PlayerRef.ModActorValue("Stamina", SCS_Mechanics_Global_KissOfDeath_Amount.value)
		PlayerRef.ModActorValue("Health", SCS_Mechanics_Global_KissOfDeath_Amount.value)
	endIf

	int TargetLevel = 1
	If akTarget
		TargetLevel = akTarget.GetLevel()
	EndIf
	PlayerRef.RestoreActorValue("Health", (100 + TargetLevel * 20))
	PlayerRef.RestoreActorValue("Magicka", (100 + TargetLevel * 20))
	PlayerRef.RestoreActorValue("Stamina", (100 + TargetLevel * 20))
	
	if akIsEmbrace && !akIsLethal
		SCS_Mechanics_Spell_FeedEmbrace_Target.Cast(PlayerRef, akTarget)
	endIf
	if akTarget && !akIsLethal && PlayerRef.HasPerk(SCS_PsychicVampire_Perk)
		SCS_Mechanics_Spell_PsychicVampire_Target.Cast(PlayerRef, akTarget)
	endIf

	PlayerRef.DispelSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc)
	PlayerRef.DispelSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodIsPower)
	if akIsLethal
		Int HemoSize = SCS_Mechanics_FormList_HemomancyExpanded.GetSize()
		if SCS_VampireSpells_Hemomancy_Global_Stage.GetValue() < HemoSize
			if !SCS_Sommelier_Quest.IsRunning()
				SCS_Sommelier_Quest.Start()
				SCS_Help_GetHemomancyByFeeding.ShowAsHelpMessage("SCS_GetHemomancyByFeedingEvent", 5, 0, 1)
			endIf
			if SCS_VampireSpells_Hemomancy_Global_Stage.GetValue() == 0
				PlayerRef.AddSpell(SCS_Abilities_Mechanics_Spell_Ab_AddRemoveHemomancySpells, false)
			endIf
			SCS_VampireSpells_Hemomancy_Global_Stage_Steps.Mod(1)
			if SCS_VampireSpells_Hemomancy_Global_Stage_Steps.GetValue() >= SCS_VampireSpells_Hemomancy_Global_Stage_StepsToNext.GetValue()
				SCS_Mechanics_Message_HemomancyStageUp.Show()
				PlayerRef.AddSpell(SCS_Mechanics_FormList_HemomancyExpanded.GetAt(SCS_VampireSpells_Hemomancy_Global_Stage.GetValue() as Int) as spell, true)
				SCS_VampireSpells_Hemomancy_Global_Stage_Steps.SetValue(0)
				SCS_VampireSpells_Hemomancy_Global_Stage.Mod(1)
				SCS_VampireSpells_Hemomancy_Global_Stage_StepsToNext.Mod(SCS_VampireSpells_Hemomancy_Global_Stage_StepsToNext_AddPerStep.GetValue())
			endIf
			if SCS_VampireSpells_Hemomancy_Global_Stage.GetValue() >= HemoSize && SCS_Sommelier_Quest.IsRunning()
				SCS_Sommelier_Quest.CompleteQuest()
			endIf
		endIf
	endIf
	if akTarget && self.GetStage() == 10
		actorbase TargetBase = akTarget.GetActorBase()
		Int Index = SCS_Mechanics_FormList_StrongBlood_Track.Find(TargetBase)
		if Index >= 0
			SCS_Help_StrongBlood.ShowAsHelpMessage("SCS_StrongBloodEvent", 5, 0, 1)
			SCS_Mechanics_Message_StrongBlood.Show()
			PlayerRef.AddSpell(SCS_Spell[StrongBloodCounter], true)
			StrongBloodCounter += 1
			SCS_Mechanics_FormList_StrongBlood_Track.RemoveAddedForm(TargetBase)
			Int RemainingSize = SCS_Mechanics_FormList_StrongBlood_Track.GetSize()
			if RemainingSize <= SCS_Mechanics_FormList_StrongBlood.GetSize() - SCS_Spell.length
				self.SetStage(200)
			endIf
		endIf
	endIf

	if akIsLethal && PlayerRef.HasPerk(SCS_LethalFeedXP) && !akTarget.IsCommandedActor() && !akTarget.IsGhost()
		DLC1VampireBloodPoints.value = DLC1VampireBloodPoints.value + 1 as Float
		if DLC1VampireTotalPerksEarned.value < DLC1VampireMaxPerks.value
			DLC1BloodPointsMsg.Show()
			if DLC1VampireBloodPoints.value >= DLC1VampireNextPerk.value
				DLC1VampireBloodPoints.value = DLC1VampireBloodPoints.value - DLC1VampireNextPerk.value
				DLC1VampirePerkPoints.value = DLC1VampirePerkPoints.value + 1 as Float
				DLC1VampireTotalPerksEarned.value = DLC1VampireTotalPerksEarned.value + 1 as Float
				DLC1VampireNextPerk.value = DLC1VampireNextPerk.value + 1 as Float
				DLC1VampirePerkEarned.Show()
			endIf
			PlayerRef.SetActorValue("VampirePerks", DLC1VampireBloodPoints.value / DLC1VampireNextPerk.value * 100)
		endIf
	endIf
	if akIsSleeping
		SCS_VampireSpells_Vanilla_Power_Message_CanLamaesWrath.SetValue(1)
	endIf
	if akTarget && (akIsSleeping && !akIsLethal && (SCS_Mechanics_Global_ForceUniqueCheck.GetValue() == 0 as Float || akTarget.GetActorBase().IsUnique()) && PlayerRef.HasSpell(SCS_Abilities_Reward_Spell_BloodBond_Ab as form) && !akTarget.IsInFaction(CurrentFollowerFaction) && !akIsEmbrace)
		akTarget.SetRelationshipRank(PlayerRef, 4)
		PlayerRef.SetRelationshipRank(akTarget, 4)
		akTarget.AddToFaction(PotentialFollowerFaction)
		akTarget.AddToFaction(PotentialMarriageFaction)
		SCS_Mechanics_Message_BloodBond.Show()
	endIf
	SCS_Mechanics_Global_Wassail_Current.SetValue(0)
	Float RestoreAmount = SCS_Mechanics_Global_Wassail_NerfAmount.GetValue()
	if SCS_Stat0
		PlayerRef.ModActorValue(SCS_Stat0, RestoreAmount)
	endIf
	if SCS_Stat1
		PlayerRef.ModActorValue(SCS_Stat1, RestoreAmount)
	endIf
	if SCS_Stat2
		PlayerRef.ModActorValue(SCS_Stat2, RestoreAmount)
	endIf
	SCS_Mechanics_Global_Wassail_NerfAmount.SetValue(0)
	PlayerRef.DispelSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc)
	if akIsLethal && PlayerRef.HasSpell(SCS_Abilities_Reward_Spell_HarvestMoon_Ab)
		PlayerRef.AddItem(DLC1BloodPotion, 1, false)
	endIf
	if akIsLethal
		SCS_Main500_Quest.Age(SCS_Mechanics_Global_Age_BonusFromDrain.GetValue())
	else
		SCS_Main500_Quest.Age(SCS_Mechanics_Global_Age_BonusFromFeed.GetValue())
	endIf
	utility.Wait(5)
	game.SetPlayerAIDriven(false)
endFunction

function OnInit()
	utility.Wait(15)
	if PlayerVampireQuest.TestIntegrity() != true || DLC1PlayerVampireQuest.TestIntegrity() != true
		SCS_Mechanics_Message_ScriptsBroken.Show()
	endIf
endFunction

; Skipped compiler generated GotoState

function InitFeedList()

	Int i = 0
	while i < SCS_Mechanics_FormList_StrongBlood.GetSize()
		SCS_Mechanics_FormList_StrongBlood_Track.AddForm(SCS_Mechanics_FormList_StrongBlood.GetAt(i))
		i += 1
	endWhile
endFunction

; Skipped compiler generated GetState
