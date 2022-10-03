scriptName SQL_FeedManager_Script extends Quest

;-- Properties --------------------------------------
globalvariable property SQL_Mechanics_Global_XP_Feed_Level auto
spell property SQL_VampireLord_Power_Spell_VampireLord auto
globalvariable property SQL_Mechanics_Global_Drain_AmountPerRank auto
globalvariable property DLC1VampireNextPerk auto
actor property PlayerRef auto
globalvariable property DLC1VampireTotalPerksEarned auto
globalvariable property SQL_Mechanics_Global_BloodPoints_IncrementPerLevel auto
message property DLC1BloodPointsMsg auto
perk property SQL_PerkTree_Perk_VampireLord_Melee_01_FountainOfBlood auto
globalvariable property SQL_Mechanics_Global_Flag_BlockFeeding auto
globalvariable property DLC1VampireMaxPerks auto
keyword property ActorTypeNPC auto
sound property SQL_Mechanics_Marker_FeedSound auto
globalvariable property SQL_Mechanics_Global_RestoreStatsOnFeed_Base auto
globalvariable property SQL_Mechanics_Global_XP_Feed_Base auto
playervampirequestscript property PlayerVampireQuest auto
globalvariable property SQL_Mechanics_Global_Age_Bonus_Drain auto
message property DLC1VampirePerkEarned auto
magiceffect property SQL_Mechanics_Effect_Feed_RecentlyFed auto
spell property SQL_Racial_Spell_Dunmer_Proc auto
magiceffect property SQL_Racial_Effect_Dunmer_Ab auto
Float property SQL_AgeDelta = 24.0000 auto
referencealias property SQL_Target auto
globalvariable property DLC1VampirePerkPoints auto
referencealias property SQL_Player auto
spell property SQL_Mechanics_Spell_Feed auto
spell property SQL_Stages_Spell_Stage4_Power auto
potion property SQL_Potion_Potion_AdvanceAge auto
potion property DLC1BloodPotion auto
globalvariable property SQL_Mechanics_Global_XP_Drain_Level auto
globalvariable property DLC1VampireBloodPoints auto
message property SQL_Help_CantFeedOnEssential auto
dlc1playervampirechangescript property DLC1PlayerVampireQuest auto
magiceffect property SQL_Racial_Effect_Imperial_Ab auto
globalvariable property SQL_Mechanics_Global_XP_Drain_Base auto
globalvariable property SQL_Mechanics_Global_RestoreStatsOnFeed_Level auto
globalvariable property SQL_Mechanics_Global_Age_Bonus_Feed auto
dlc1vampireturnscript property DLC1VampireTurn auto
message property SQL_Mechanics_Message_ScriptsBroken auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function ProgressLifeblood()

	DLC1VampireBloodPoints.value = DLC1VampireBloodPoints.value + 1 as Float
	if DLC1VampireTotalPerksEarned.value < DLC1VampireMaxPerks.value
		DLC1BloodPointsMsg.Show()
		if DLC1VampireBloodPoints.value >= DLC1VampireNextPerk.value
			DLC1VampireBloodPoints.value = DLC1VampireBloodPoints.value - DLC1VampireNextPerk.value
			DLC1VampirePerkPoints.value = DLC1VampirePerkPoints.value + 1
			DLC1VampireTotalPerksEarned.value = DLC1VampireTotalPerksEarned.value + 1
			DLC1VampireNextPerk.value = DLC1VampireNextPerk.value + (SQL_Mechanics_Global_BloodPoints_IncrementPerLevel.GetValue())
			DLC1VampirePerkEarned.Show()
		endIf
		PlayerRef.SetActorValue("VampirePerks", DLC1VampireBloodPoints.value / DLC1VampireNextPerk.value * 100)
	endIf
	PlayerVampireQuest.AdvanceAge(PlayerRef, SQL_AgeDelta)
endFunction

function ProcessFeed(actor akTarget, Bool akIsLethal, Bool akIsSleeping, Bool akVanillaFeedAnimation, Bool akDisable)
	SQL_Mechanics_Global_Flag_BlockFeeding.SetValue(1)

	If akVanillaFeedAnimation
		PlayerRef.StartVampireFeed(akTarget)
	EndIf
	
	DLC1VampireTurn.PlayerBitesMe(akTarget)
	Int VampireStatus = PlayerVampireQuest.VampireStatus
	SQL_Mechanics_Marker_FeedSound.Play(akTarget)
	PlayerVampireQuest.VampireFeed()
	if akIsLethal
		akTarget.Kill(PlayerRef)
	endIf
	Int TargetLevel = akTarget.GetLevel()
	if TargetLevel > 50
		TargetLevel = 50
	endIf
	Float RestoreAmount = SQL_Mechanics_Global_RestoreStatsOnFeed_Base.GetValue() + TargetLevel * SQL_Mechanics_Global_RestoreStatsOnFeed_Level.GetValue()
	if PlayerRef.HasPerk(SQL_PerkTree_Perk_VampireLord_Melee_01_FountainOfBlood) && akIsLethal
		PlayerRef.RestoreActorValue("Health", RestoreAmount * 3)
		PlayerRef.RestoreActorValue("Magicka", RestoreAmount * 3)
		PlayerRef.RestoreActorValue("Stamina", RestoreAmount * 3)
	else
		PlayerRef.RestoreActorValue("Health", RestoreAmount)
	endIf
	if PlayerRef.HasMagicEffect(SQL_Racial_Effect_Dunmer_Ab)
		SQL_Racial_Spell_Dunmer_Proc.Cast(PlayerRef, akTarget)
	endIf
	SQL_Mechanics_Global_Flag_BlockFeeding.SetValue(0)
	if akIsLethal && akTarget.IsDead()
		if PlayerRef.HasSpell(SQL_VampireLord_Power_Spell_VampireLord)
			self.ProgressLifeblood()
		endIf
		if PlayerRef.HasMagicEffect(SQL_Racial_Effect_Imperial_Ab)
			if utility.RandomFloat(0, 1) < 0.25
				PlayerRef.AddItem(SQL_Potion_Potion_AdvanceAge, 1, false)
			else
				PlayerRef.AddItem(DLC1BloodPotion, 1, false)
			endIf
		endIf
	endIf
	if akIsLethal
		if akTarget.HasKeyword(ActorTypeNPC)
			PlayerVampireQuest.AdvanceAge(PlayerRef, SQL_Mechanics_Global_Age_Bonus_Drain.GetValue())
			game.AdvanceSkill("Destruction", SQL_Mechanics_Global_XP_Drain_Base.GetValue() + TargetLevel * SQL_Mechanics_Global_XP_Drain_Level.GetValue())
		else
			PlayerVampireQuest.AdvanceAge(PlayerRef, SQL_Mechanics_Global_Age_Bonus_Drain.GetValue() * 0.25)
			game.AdvanceSkill("Destruction", (SQL_Mechanics_Global_XP_Drain_Base.GetValue() + TargetLevel * SQL_Mechanics_Global_XP_Drain_Level.GetValue()) * 0.25)
		endIf
	else
		PlayerVampireQuest.AdvanceAge(PlayerRef, SQL_Mechanics_Global_Age_Bonus_Feed.GetValue())
		game.AdvanceSkill("Destruction", SQL_Mechanics_Global_XP_Feed_Base.GetValue() + TargetLevel * SQL_Mechanics_Global_XP_Feed_Level.GetValue())
	endIf
	if PlayerVampireQuest.TestIntegrity() != 777
		SQL_Mechanics_Message_ScriptsBroken.Show()
	endIf
endFunction

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function OnInit()

	utility.Wait(15)
	if PlayerVampireQuest.TestIntegrity() != 777 || DLC1PlayerVampireQuest.TestIntegrity() != 777
		SQL_Mechanics_Message_ScriptsBroken.Show()
	endIf
endFunction
