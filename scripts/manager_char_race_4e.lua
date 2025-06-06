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

	-- Notification
	ChatManager.SystemMessageResource("char_abilities_message_raceadd", sRaceName, rAdd.sCharName);

	-- Set name and link
	DB.setValue(rAdd.nodeChar, "race", "string", sRaceName);	
	DB.setValue(rAdd.nodeChar, "racelink", "windowreference", "powerdesc", DB.getPath(rAdd.nodeSource));
end

function addRaceFeatures(rAdd, sRecord, sDescriptionText)
	local sPattern = '<link class="powerdesc" recordname="reference.features.(%w+)@([%w%s]+)">'
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
    	end
	end
end

function addRacePowers(rAdd, sRecord, sDescriptionText)
	local referenceStaticNode = DB.findNode("reference.powers.");
	local powersNode = DB.getChild(referenceStaticNode, "powers");
	local sPowersPattern = '<link class="powerdesc" recordname="reference.powers.(%w+)@([%w%s]+)">'
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
		Debug.console("nodePowerChildren:",nodePowerChildren);
		for nodeName,nodeChild in pairs(nodePowerChildren) do
			Debug.console("Flavor:",DB.getText(DB.getPath(nodeChild, "flavor")));
			Debug.console("Description:",DB.getText(DB.getPath(nodeChild, "shortdescription")));
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
	local sRecordTraitsNode = DB.findNode(DB.getPath(sRecord, "powers"));
end

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

