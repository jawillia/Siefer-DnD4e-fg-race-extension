-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

aRecordOverrides = {
	["race"] = {
		aDataMap = { "race", "reference.races" }, 
		sListDisplayClass = "masterindexitem_id",
		sRecordDisplayClass = "reference_race", 
		tOptions = {
			bExport = true,
		}
	}
};

function onInit()
	LibraryData.overrideRecordTypes(aRecordOverrides);
end