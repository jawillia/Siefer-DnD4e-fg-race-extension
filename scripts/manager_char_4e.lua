-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

--
-- LINK HANDLING
--

function onRaceLinkPressed(nodeChar)
	local _, sRecord = DB.getValue(nodeChar, "racelink", "", "");
	if CharManagerWith4ERaceExtension.helperOpenLinkRecord("race", sRecord) then
		return true;
	end
	-- local sName = DB.getValue(nodeChar, "racename", "");
	-- local bIs2024 = (DB.getValue(nodeChar, "raceversion", "") == "2024");
	-- if CharManager.helperOpenAltLinkRecord("race", sName, bIs2024) then
	-- 	return true;
	-- end
	CharManagerWith4ERaceExtension.helperOpenLinkRecordFail("race", sRecord);
	return false;
end

function helperOpenLinkRecord(sRecordType, sRecord)
	if ((sRecord or "") == "") or ((sRecordType or "") == "") then
		return false;
	end
	local nodeRecord = DB.findNode(sRecord);
	if nodeRecord then
		local sDisplayClass = RecordDataManager.getRecordTypeDisplayClass(sRecordType, nodeRecord);
		Interface.openWindow(sDisplayClass, nodeRecord);
		return true;
	end
	return false;
end
function helperOpenAltLinkRecord(sRecordType, sName, bIs2024)
	if ((sName or "") == "") or ((sRecordType or "") == "") then
		return false;
	end
	local tFilters = {
		{ sField = "name", sValue = sName, bIgnoreCase = true, },
		{ sField = "version", sValue = (bIs2024 and "2024" or ""), },
	};
	local nodeRecord = RecordManager.findRecordByFilter(sRecordType, tFilters);
	if nodeRecord then
		local sDisplayClass = RecordDataManager.getRecordTypeDisplayClass(sRecordType, nodeRecord);
		Interface.openWindow(sDisplayClass, nodeRecord);
		return true;
	end
	return false;
end
function helperOpenLinkRecordFail(sRecordType, sRecord)
	local sDisplay = LibraryData.getSingleDisplayText(sRecordType);
	local sModuleDisplay = ModuleManager.getModuleDisplayName(DB.getModule(sRecord));
	ChatManager.SystemMessage(string.format(Interface.getString("char_error_missinglink"), sDisplay, sModuleDisplay));
end

