-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function addRace(nodeChar, sRecord, tData)
	local rAdd = CharBuildDropManager.helperBuildAddStructure(nodeChar, "powerdesc", sRecord, tData);
	local sRaceName = DB.getText(DB.getPath(sRecord, "name"));

	-- Add Race Features
	---- First tries through the description of the database module
	local sRecordDescriptionNode = DB.findNode(DB.getPath(sRecord, "description"));
	local sDescriptionText = DB.getValue(sRecordDescriptionNode);
	addRaceFeatures(rAdd, sRecord, sDescriptionText);

	--Add Race Powers
	addRacePowers(rAdd, sRecord, sDescriptionText);

	--Add Traits
	addRaceTraits(rAdd, sRecord, sDescriptionText);

	--Add skill bonuses
	addRaceSkill(rAdd, sRecord, sDescriptionText);

	--Add ability score bonuses
	CharRaceManager.helperResolveStatIncreaseOnRaceDrop(rAdd, sRecord, sDescriptionText);

	-- Notification
	ChatManager.SystemMessageResource("char_abilities_message_raceadd", sRaceName, rAdd.sCharName);

	-- Set name and link
	DB.setValue(rAdd.nodeChar, "race", "string", sRaceName);	
	DB.setValue(rAdd.nodeChar, "racelink", "windowreference", "powerdesc", DB.getPath(rAdd.nodeSource));
end

function addRaceFeatures(rAdd, sRecord, sDescriptionText)
	local sPattern = '<link class="powerdesc" recordname="reference.features.(%w+)@([%w%s]+)">';
	local sFeaturesLink = string.gmatch(sDescriptionText, sPattern);
	local isDescriptionFeatureLinkEmpty = true;
	for w,v in sFeaturesLink do
		isDescriptionFeatureLinkEmpty = false;
		local sPattern = "reference.features." .. w .. "@" .. v;
		local sRacialFeatureName = DB.getText(DB.getPath(sPattern, "name"));
		local rCreatedIDChildNode = DB.createChild(rAdd.nodeChar.getPath("specialabilitylist"));
		DB.setValue(rCreatedIDChildNode, "shortcut", "windowreference", "powerdesc", sPattern);
		DB.setValue(rCreatedIDChildNode, "value", "string", sRacialFeatureName);
		ChatManager.SystemMessageResource("char_abilities_message_featureadd", sRacialFeatureName, rAdd.sCharName);
	end
	---- then through the newly added feature tag
	if isDescriptionFeatureLinkEmpty == true then
		local sRecordFeatureNode = DB.findNode(DB.getPath(sRecord, "features"));
		local nodeFeatureChildren = DB.getChildren(sRecordFeatureNode);
		for nodeName,nodeChild in pairs(nodeFeatureChildren) do
			local rCreatedIDChildNode = DB.createChild(rAdd.nodeChar.getPath("specialabilitylist"));
			DB.setValue(rCreatedIDChildNode, "description", "string", DB.getText(DB.getPath(nodeChild, "description")));
      		DB.createChild(rCreatedIDChildNode, "shortcut", "windowreference");
      		DB.setValue(rCreatedIDChildNode, "value", "string", DB.getText(DB.getPath(nodeChild, "name")));
      		local sRacialFeatureName = DB.getText(rCreatedIDChildNode, "value");
      		ChatManager.SystemMessageResource("char_abilities_message_featureadd", sRacialFeatureName, rAdd.sCharName);
    	end
	end
end

function addRacePowers(rAdd, sRecord, sDescriptionText)
	local referenceStaticNode = DB.findNode("reference.powers.");
	local powersNode = DB.getChild(referenceStaticNode, "powers");
	local sPowersPattern = '<link class="powerdesc" recordname="reference.powers.(%w+)@([%w%s]+)">';
	local sPowersLink = string.gmatch(sDescriptionText, sPowersPattern);
	local isDescriptionPowerLinkEmpty = true;
	for w,v in sPowersLink do
		isDescriptionPowerLinkEmpty = false;
		local sPowersPattern = "reference.powers." .. w .. "@" .. v;
		local sRacialPowerName = DB.getText(DB.getPath(sPowersPattern, "name"));
		local sRacialActionSpeed = DB.getText(DB.getPath(sPowersPattern, "action"));
		local sRacialSource = DB.getText(DB.getPath(sPowersPattern, "source"));
		local sRacialKeywords = DB.getText(DB.getPath(sPowersPattern, "keywords"));
		local sRacialRange = DB.getText(DB.getPath(sPowersPattern, "range"));
		local sRacialRecharge = DB.getText(DB.getPath(sPowersPattern, "recharge"));
		local sRacialFullDescription = DB.getText(DB.getPath(sPowersPattern, "flavor")) .. "\n\n" .. DB.getText(DB.getPath(sPowersPattern, "description"))
		local rCreatedIDChildNode = DB.createChild(rAdd.nodeChar.getPath("powers"));
		DB.setValue(rCreatedIDChildNode, "action", "string", sRacialActionSpeed);
		DB.setValue(rCreatedIDChildNode, "name", "string", sRacialPowerName);
		DB.setValue(rCreatedIDChildNode, "source", "string", sRacialSource);
		DB.setValue(rCreatedIDChildNode, "keywords", "string", sRacialKeywords);
		DB.setValue(rCreatedIDChildNode, "range", "string", sRacialRange);
		DB.setValue(rCreatedIDChildNode, "recharge", "string", sRacialRecharge);
		DB.setValue(rCreatedIDChildNode, "shortdescription", "string", sRacialFullDescription);
		CharManager.parseDescription(rCreatedIDChildNode);
		ChatManager.SystemMessageResource("char_abilities_message_poweradd", sRacialPowerName, rAdd.sCharName);
	end
	---- then through the newly added power tag
	if isDescriptionPowerLinkEmpty == true then
		local sRecordPowerNode = DB.findNode(DB.getPath(sRecord, "powers"));
		local nodePowerChildren = DB.getChildren(sRecordPowerNode);
		for nodeName,nodeChild in pairs(nodePowerChildren) do
			local sRacialPowerName = DB.getText(DB.getPath(nodeChild, "name"));
			local sRacialActionSpeed = DB.getText(DB.getPath(nodeChild, "action"));
			local sRacialSource = DB.getText(DB.getPath(nodeChild, "source"));
			local sRacialKeywords = DB.getText(DB.getPath(nodeChild, "keywords"));
			local sRacialRange = DB.getText(DB.getPath(nodeChild, "range"));
			local sRacialRecharge = DB.getText(DB.getPath(nodeChild, "recharge"));
			local sRacialFlavor = DB.getText(DB.getPath(nodeChild, "flavor"));
			if sRacialFlavor == nil then
				sRacialFlavor = "";
			end
			local sRacialFullDescription = sRacialFlavor .. "\n\n" .. DB.getText(DB.getPath(nodeChild, "shortdescription"));
			local rCreatedIDChildNode = DB.createChild(rAdd.nodeChar.getPath("powers"));
			DB.setValue(rCreatedIDChildNode, "action", "string", sRacialActionSpeed);
			DB.setValue(rCreatedIDChildNode, "name", "string", sRacialPowerName);
			DB.setValue(rCreatedIDChildNode, "source", "string", sRacialSource);
			DB.setValue(rCreatedIDChildNode, "keywords", "string", sRacialKeywords);
			DB.setValue(rCreatedIDChildNode, "range", "string", sRacialRange);
			DB.setValue(rCreatedIDChildNode, "recharge", "string", sRacialRecharge);
			DB.setValue(rCreatedIDChildNode, "shortdescription", "string", sRacialFullDescription);
			CharManager.parseDescription(rCreatedIDChildNode);
			ChatManager.SystemMessageResource("char_abilities_message_poweradd", sRacialPowerName, rAdd.sCharName);
    	end
	end
end

function addRaceTraits(rAdd, sRecord, sDescriptionText)
	-- Parsing Order for these: 
	--- 1) First checks race speed node, 
	--- 2) Then traits nodes, 
	--- 3) Then description text
	addRaceSpeed(rAdd, sRecord, sDescriptionText);
	addRaceSize(rAdd, sRecord, sDescriptionText);
	addRaceVision(rAdd, sRecord, sDescriptionText);
	addRaceLanguages(rAdd, sRecord, sDescriptionText);
end

function addRaceSpeed(rAdd, sRecord, sDescriptionText)
	local nSpeedValue = '';
	local sSpecialSpeed = '';
	local rSpeedNode = DB.findNode(DB.getPath(sRecord, "speed"));
	if rSpeedNode then
			sSpecialSpeed = string.match(DB.getText(rSpeedNode), "%.(.*)");
			nSpeedValue = string.match(DB.getText(rSpeedNode), "%d+");
	elseif DB.findNode(DB.getPath(sRecord, "traits")) then
		local rRecordTraitsNode = DB.findNode(DB.getPath(sRecord, "traits"));
		local rSpeedTraitsNode = DB.getChild(rRecordTraitsNode, "speed");
		if rSpeedTraitsNode then
			local sSpeedText = DB.getChild(rSpeedTraitsNode, "text");
			sSpecialSpeed = string.match(DB.getText(sSpeedText), "%.(.*)");
			nSpeedValue = string.match(DB.getText(sSpeedText), "%d+");
		end
	elseif sDescriptionText then
		local sSpeedDescriptionTextLine = string.match(sDescriptionText, "<p>%s*<b>%s*Speed%s*</b>%s*:%s*(.-)</p>");
		nSpeedValue = string.match(sSpeedDescriptionTextLine, "%d+");
		sSpecialSpeed = string.match(sSpeedDescriptionTextLine, "%.(.*)");
	end
	local rCharacterSpeedNode = DB.findNode(rAdd.nodeChar.getPath("speed"));
	if rCharacterSpeedNode and nSpeedValue then
		DB.setValue(rCharacterSpeedNode, "base", "number", nSpeedValue);
		ChatManager.SystemMessageResource("char_combat_message_speedadd", nSpeedValue, rAdd.sCharName);
	end
	if rCharacterSpeedNode and sSpecialSpeed then
		DB.setValue(rCharacterSpeedNode, "special", "string", sSpecialSpeed);
		ChatManager.SystemMessageResource("char_main_message_specialspeedadd", sSpecialSpeed, rAdd.sCharName);
	end
end

function addRaceSize(rAdd, sRecord, sDescriptionText)
	local sSizeValue = '';
	local rSizeNode = DB.findNode(DB.getPath(sRecord, "size"));
	if rSizeNode then
			sSizeValue = DB.getText(rSizeNode);
	elseif DB.findNode(DB.getPath(sRecord, "traits")) then
		local rRecordTraitsNode = DB.findNode(DB.getPath(sRecord, "traits"));
		if rRecordTraitsNode then
			local rSizeTraitsNode = DB.getChild(rRecordTraitsNode, "size");
			if rSizeTraitsNode then
				local rSizeTextNode = DB.getChild(rSizeTraitsNode, "text");
				sSizeValue = DB.getText(rSizeTextNode);
			end
		end
	elseif sDescriptionText then
		local sSizeDescriptionTextLine = string.match(sDescriptionText, "<p>%s*<b>%s*Size%s*</b>%s*:%s*(.-)</p>");
		sSizeValue = string.match(sSizeDescriptionTextLine, "%a+");
	end
	if sSizeValue then
		DB.setValue(rAdd.nodeChar, "size", "string", sSizeValue);
		ChatManager.SystemMessageResource("char_notes_message_sizeadd", sSizeValue, rAdd.sCharName);
	end
end

function addRaceVision(rAdd, sRecord, sDescriptionText)
	local sVisionValue = '';
	local rVisionNode = DB.findNode(DB.getPath(sRecord, "vision"));
	if rVisionNode then
			sVisionValue = DB.getText(rVisionNode);
	elseif DB.findNode(DB.getPath(sRecord, "traits")) then
		local rRecordTraitsNode = DB.findNode(DB.getPath(sRecord, "traits"));
		if rRecordTraitsNode then
			local rVisionTraitsNode = DB.getChild(rRecordTraitsNode, "vision");
			if rVisionTraitsNode then
				local rVisionTextNode = DB.getChild(rVisionTraitsNode, "text");
				sVisionValue = DB.getText(rVisionTextNode);
			end
		end
	elseif sDescriptionText then
		local sVisionDescriptionTextLine = string.match(sDescriptionText, "<p>%s*<b>%s*Vision%s*</b>%s*:%s*(.-)</p>");
		sVisionValue = string.match(sVisionDescriptionTextLine, "[%a-]+");
	end
	if sVisionValue then
		DB.setValue(rAdd.nodeChar, "senses", "string", sVisionValue);
		ChatManager.SystemMessageResource("char_main_message_visionadd", sVisionValue, rAdd.sCharName);
	end
end

function addRaceLanguages(rAdd, sRecord, sDescriptionText)
	local sLanguagesValue = '';
	local rLanguagesNode = DB.findNode(DB.getPath(sRecord, "languages"));
	if rLanguagesNode then
			sLanguagesValue = DB.getText(rLanguagesNode);
	elseif DB.findNode(DB.getPath(sRecord, "traits")) then
		local rRecordTraitsNode = DB.findNode(DB.getPath(sRecord, "traits"));
		if rRecordTraitsNode then
			local rLanguagesTraitsNode = DB.getChild(rRecordTraitsNode, "languages");
			if rLanguagesTraitsNode then
				local rLanguageTextNode = DB.getChild(rLanguagesTraitsNode, "text");
				sLanguagesValue = DB.getText(rLanguageTextNode);
			end
		end
	elseif sDescriptionText then
		local sLanguagesDescriptionTextLine = string.match(sDescriptionText, "<p>%s*<b>%s*Languages%s*</b>%s*:%s*(.-)</p>");
		sLanguagesValue = string.match(sLanguagesDescriptionTextLine, "[%a,%s]+");
	end
	local tLanguages = StringManager.split(sLanguagesValue, ',', true);
	local tCurrentLanguages = DB.getChildren(rAdd.nodeChar, "languagelist");
	for _,x in pairs(tLanguages) do
		local isLanguageInList = false;
		for languageName, languageNode in pairs(tCurrentLanguages) do
			if DB.getText(DB.getPath(languageNode, "name")) == x then
				isLanguageInList = true;
			end
		end
		if isLanguageInList == false then
			local rCreatedIDChildNode = DB.createChild(rAdd.nodeChar.getPath("languagelist"));
			DB.setValue(rCreatedIDChildNode, "name", "string", x);
			ChatManager.SystemMessageResource("char_notes_message_languageadd", x, rAdd.sCharName);
		end
	end
end

function addRaceSkill(rAdd, sRecord, sDescriptionText)
	--Reset racial skill bonuses before adding new ones
	for __,y in pairs(DB.getChildren(rAdd.nodeChar, "skilllist")) do
		DB.setValue(y, "race", "number", "0");
	end

	local sSkillValue = '';
	local rSkillsNode = DB.findNode(DB.getPath(sRecord, "skillbonuses"));
	if rSkillsNode then
		sSkillValue = DB.getText(rSkillsNode);
	elseif DB.findNode(DB.getPath(sRecord, "traits")) then
		local rRecordTraitsNode = DB.findNode(DB.getPath(sRecord, "traits"));
		local rSkillTraitsNode = DB.getChild(rRecordTraitsNode, "skillbonuses");
		if rSkillTraitsNode then
			local rSkillTextNode = DB.getChild(rSkillTraitsNode, "text");
			sSkillValue = DB.getText(rSkillTextNode);
		end
	elseif sDescriptionText then
		local sSkillBonusesDescriptionTextLine = string.match(sDescriptionText, "<p>%s*<b>%s*Skill Bonuses%s*</b>%s*:%s*(.-)</p>");
		sSkillValue = string.match(sSkillBonusesDescriptionTextLine, "[%w,%s%+]+");
	end
	if sSkillValue then
		local tSkillList = StringManager.split(sSkillValue, ',', true);
		for _,x in pairs(tSkillList) do
			local skillBonus = string.match(x, '%d');
			local skillName = string.match(x, '%a+');
			local rCreatedIDChildren = DB.getChildren(rAdd.nodeChar, "skilllist");
			for __,y in pairs(rCreatedIDChildren) do
				if DB.getText(y, "label") == skillName then
					DB.setValue(y, "race", "number", skillBonus);
				end
			end
			ChatManager.SystemMessageResource("char_skills_message_skillbonusadd", skillBonus, skillName, rAdd.sCharName);
		end
	end
end

function helperResolveStatIncreaseOnRaceDrop(rAdd, sRecord, sDescriptionText)
	if not rAdd then
		return;
	end

	--Reset racial ability score bonuses before adding new ones
	for __,y in pairs(DB.getChildren(rAdd.nodeChar, "abilities")) do
		local nCurrentAbilityScore = DB.getValue(y, "score", 0);
		local nCurrentAbilityRaceBonus = DB.getValue(y, "race", "0");
		if nCurrentAbilityRaceBonus and nCurrentAbilityRaceBonus ~= "0" then
			DB.setValue(y, "score", "number", nCurrentAbilityScore - nCurrentAbilityRaceBonus);
			DB.setValue(y, "race", "number", "0");
		end
	end

	local sAbilityScoresValue = '';
	local rAbilityScoresNode = DB.findNode(DB.getPath(sRecord, "abilityscores"));
	if rAbilityScoresNode then
			sAbilityScoresValue = DB.getText(rAbilityScoresNode);
	elseif DB.findNode(DB.getPath(sRecord, "traits")) then
		local rRecordTraitsNode = DB.findNode(DB.getPath(sRecord, "traits"));
		if rRecordTraitsNode then
			local rAbilityScoreTraitsNode = DB.getChild(rRecordTraitsNode, "abilityscores");
			if rAbilityScoreTraitsNode then
				local rAbilityScoreTextNode = DB.getChild(rAbilityScoreTraitsNode, "text");
				sAbilityScoresValue = DB.getText(rAbilityScoreTextNode);
			end
		end
	elseif sDescriptionText then
		local sAbilityScoresDescriptionTextLine = string.match(sDescriptionText, "<p>%s*<b>%s*Skill Bonuses%s*</b>%s*:%s*(.-)</p>");
		sAbilityScoresValue = string.match(sAbilityScoresDescriptionTextLine, "[%w,%s%+]+");
	end
	local tAbilityScoreBonuses = StringManager.split(sAbilityScoresValue, ',', true);
	for _,x in pairs(tAbilityScoreBonuses) do
		-- Direct increase ability scores that don't have a choice
		if not string.find(x, "or") then
			local rAbilitiesNode = DB.findNode(DB.getPath(rAdd.nodeChar, "abilities"));
			local sAbilityScoreName = string.match(x, "%a+");
			local nAbiltyScoreBonusNumber = string.match(x, "%d+");
			if not nAbiltyScoreBonusNumber then
				nAbiltyScoreBonusNumber = "2";
			end
			local rAbilitiesNodeChild = DB.getChild(rAbilitiesNode, string.lower(sAbilityScoreName));
			if rAbilitiesNodeChild then
				local nCurrentAbilityScore = DB.getValue(rAbilitiesNodeChild, "score", 0);
				DB.setValue(rAbilitiesNodeChild, "race", "number", nAbiltyScoreBonusNumber);
				DB.setValue(rAbilitiesNodeChild, "score", "number", nCurrentAbilityScore + nAbiltyScoreBonusNumber);
				ChatManager.SystemMessageResource("char_main_message_statbonusadd", nAbiltyScoreBonusNumber, sAbilityScoreName, rAdd.sCharName);
			end
		end
		
		-- Display a selection dialogue if there is a choice for ability score increase
		if string.match(x, "or") then
			local tOptions = StringManager.splitByPattern(x, "or", true);
			local tDialogData = {
				title = Interface.getString("char_build_title_selectraceabilitybonus"),
				msg = Interface.getString("char_build_message_selectraceabilitybonus"),
				options = tOptions,
				callback = CharRaceManager.callbackResolveStatIncreaseOnRaceDrop,
				custom = rAdd,
			};
			DialogManager.requestSelectionDialog(tDialogData);
		end
	end
end
function callbackResolveStatIncreaseOnRaceDrop(tSelection, rAdd, tSelectionLinks)
	if not tSelectionLinks or (#tSelectionLinks ~= 1) then
		CharManager.outputUserMessage("char_error_addrace");
		return;
	end
	if not tSelection then
		CharManager.outputUserMessage("char_error_addrace");
		return;
	end
	local rAbilitiesNode = DB.findNode(DB.getPath(rAdd.nodeChar, "abilities"));
	local sAbilityScore = string.lower(string.match(tSelection[1], "%a+"));
	local nSelectionBonus = string.match(tSelection[1], "%d+");
	if not nSelectionBonus then
		nSelectionBonus = "2";
	end
	local rAbilitiesNodeChildren = DB.getChildren(rAbilitiesNode);
	for _,x in pairs(rAbilitiesNodeChildren) do
		if DB.getName(x) == sAbilityScore then
			local nCurrentAbilityScore = DB.getValue(x, "score", 0);
			DB.setValue(x, "race", "number", nSelectionBonus);
			DB.setValue(x, "score", "number", nCurrentAbilityScore + nSelectionBonus);
			ChatManager.SystemMessageResource("char_main_message_statbonusadd", nSelectionBonus, sAbilityScore, rAdd.sCharName);
		end
	end
end

-----------------------------------------------------------

function helperResolveAncestryOnRaceDrop(rAdd)
	if not rAdd then
		return;
	end
	local tOptions = CharSpeciesManager.getAncestryOptions(rAdd.nodeSource, rAdd.bSource2024);
	if #tOptions == 0 then
		CharSpeciesManager.helperAddSpecies(rAdd);
		return;
	end

	if #tOptions == 1 then
		-- Automatically select only ancestry
		rAdd.sAncestryPath = tOptions[1].linkrecord;
		CharSpeciesManager.helperAddSpecies(rAdd);
		return;
	end

	local tDialogData = {
		title = Interface.getString("char_build_title_selectancestry"),
		msg = Interface.getString("char_build_message_selectancestry"),
		options = tOptions,
		callback = CharSpeciesManager.callbackResolveAncestryOnSpeciesDrop,
		custom = rAdd,
	};
	DialogManager.requestSelectionDialog(tDialogData);
end
function callbackResolveAncestryOnSpeciesDrop(tSelection, rAdd, tSelectionLinks)
	if not tSelectionLinks or (#tSelectionLinks ~= 1) then
		CharManager.outputUserMessage("char_error_addancestry");
		return;
	end
	rAdd.sAncestryPath = tSelectionLinks[1].linkrecord;
	CharSpeciesManager.helperAddSpecies(rAdd);
end
function helperAddSpecies(rAdd)
	CharSpeciesManager.helperAddSpeciesMain(rAdd);
	CharSpeciesManager.helperAddAncestry(rAdd);
end
function helperAddSpeciesMain(rAdd)
	if not rAdd then
		return;
	end

	-- Notification
	ChatManager.SystemMessageResource("char_abilities_message_raceadd", rAdd.sSourceName, rAdd.sCharName);

	-- Set name and link
	DB.setValue(rAdd.nodeChar, "race", "string", rAdd.sSourceName);
	DB.setValue(rAdd.nodeChar, "racelink", "windowreference", "reference_race", DB.getPath(rAdd.nodeSource));
	DB.setValue(rAdd.nodeChar, "racename", "string", sSourceName);
	DB.setValue(rAdd.nodeChar, "raceversion", "string", DB.getValue(rAdd.nodeSource, "version", ""));
	DB.setValue(rAdd.nodeChar, "subracelink", "windowreference", "", "");

	CharSpeciesManager.helperAddSpeciesMainStats(rAdd);

	-- Add species traits
	for _,v in ipairs(DB.getChildList(rAdd.nodeSource, "traits")) do
		CharSpeciesManager.addSpeciesTrait(rAdd.nodeChar, DB.getPath(v), { bWizard = rAdd.bWizard });
	end
end
function helperAddSpeciesMainStats(rAdd)
	if not rAdd or rAdd.bWizard then
		return;
	end

	if rAdd.bSource2024 then
		CharBuildDropManager.handleSizeField2024(rAdd);
		CharBuildDropManager.handleSpeedField2024(rAdd);
		CharBuildDropManager.handleSpeciesLanguage2024(rAdd);
	end
end

