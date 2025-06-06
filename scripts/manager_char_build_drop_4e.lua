-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

--
-- CHARACTER SHEET DROPS
--

function addInfoDB(nodeChar, sClass, sRecord)
	-- Validate parameters
	if not nodeChar then
		return false;
	end
	if StringManager.startsWith(sRecord, "reference.races") or StringManager.startsWith(sRecord, "race.id-") then
		CharRaceManager.addRace(nodeChar, sRecord);

	else
		return false;
	end
	
	return true;	
end

--
--	BUILD
--

function helperBuildAddStructure(nodeChar, sClass, sRecord, tData)
	if not nodeChar or ((sClass or "") == "") or ((sRecord or "") == "") then
		return nil;
	end

	local rAdd = { };
	rAdd.nodeSource = DB.findNode(sRecord);
	if not rAdd.nodeSource then
		return nil;
	end

	rAdd.sSourceClass = sClass;
	-- if sClass == "reference_classfeaturechoice" then
	-- 	rAdd.sSourceName = CharClassManager.getFeatureChoiceDisplayName(rAdd.nodeSource);
	-- else
	-- 	rAdd.sSourceName = StringManager.trim(DB.getValue(rAdd.nodeSource, "name", ""));
	-- end

	rAdd.nodeChar = nodeChar;
	rAdd.sCharName = StringManager.trim(DB.getValue(nodeChar, "name", ""));

	rAdd.sSourceType = StringManager.simplify(rAdd.sSourceName);
	if rAdd.sSourceType == "" then
		rAdd.sSourceType = DB.getName(rAdd.nodeSource);
	end

	-- if StringManager.contains({ "reference_background", "reference_class", "reference_class_specialization", "reference_feat", "reference_race", "reference_subrace", }, sClass) then
	-- 	rAdd.bSource2024 = (DB.getValue(rAdd.nodeSource, "version", "") == "2024");
	-- elseif StringManager.contains({ "reference_backgroundfeature", "reference_classfeature", "reference_classfeaturechoice", "reference_racialtrait", "reference_subracialtrait", }, sClass) then
	-- 	rAdd.bSource2024 = (DB.getValue(rAdd.nodeSource, "...version", "") == "2024");
	-- elseif StringManager.contains({ "reference_classproficiency", }, sClass) then
	-- 	rAdd.bSource2024 = (DB.getValue(rAdd.nodeSource, "...version", "") == "2024");
	-- end

	rAdd.bWizard = tData and tData.bWizard;
	if StringManager.contains({ "reference_classfeature", "reference_classfeaturechoice", }, sClass) then
		rAdd.nodeCharClass = tData and tData.nodeCharClass;
		rAdd.nodeClass = tData and tData.nodeClass or DB.getChild(rAdd.nodeSource, "...");
	end
	
	return rAdd;
end