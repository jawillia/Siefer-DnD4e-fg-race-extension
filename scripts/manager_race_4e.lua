-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--
function checkForSpeed(nodeRace)
	-- Validate parameters
	if not nodeRace then
		return nil;
	end
	
	-- Get the speed node
	local nodeSpeed = DB.createChild(nodeRace, "speed", "string");

	if not nodeSpeed or DB.getValue(nodeSpeed) == ""
		then
			--Get the speed trait
			local nodeTraitsList = DB.getChildList(nodeRace, "traits");
			for _,v in ipairs(nodeTraitsList) do
				if string.lower(DB.getText(DB.getChild(v, "name"))) == "speed" then
					local stringSpeed =  DB.getText(DB.getChild(v, "text"));
					DB.setValue(nodeRace, "speed", "string", stringSpeed);
				end
			end
		else
			local stringSpeed = DB.getText(nodeSpeed);
	end
	
	-- -- Check for existing Racial Traits power
	-- for _,v in ipairs(DB.getChildList(nodeTraitsList)) do
	-- 	if DB.getValue(v, "name", "") == "Second Wind" then
	-- 		return v;
	-- 	end
	-- end
	
	-- -- Create a new power node
	-- local nodeNewPower = DB.createChild(nodePowerList);
	
	-- -- Set up the basic power fields
  	-- DB.setValue(nodeNewPower, "name", "string", "Second Wind");
  	-- DB.setValue(nodeNewPower, "source", "string", "General");
  	-- DB.setValue(nodeNewPower, "recharge", "string", "Encounter");
  	-- DB.setValue(nodeNewPower, "keywords", "string", "Healing");
  	-- DB.setValue(nodeNewPower, "range", "string", "Personal");
	-- DB.setValue(nodeNewPower, "action", "string", "Standard");
	-- DB.setValue(nodeNewPower, "shortdescription", "string", "Effect: You spend a healing surge, and gain a +2 bonus to all defenses until the start of your next turn.");
	
	-- -- Now parse the description to pre-fill the ability items
	-- parseDescription(nodeNewPower);

	-- -- Return the new power created
	-- return nodeNewPower;
end

function checkForSize(nodeRace)
	-- Validate parameters
	if not nodeRace then
		return nil;
	end
	
	-- Get the size node
	local nodeSize = DB.createChild(nodeRace, "size", "string");

	if not nodeSize or DB.getValue(nodeSize) == ""
		then
			--Get the size trait
			local nodeTraitsList = DB.getChildList(nodeRace, "traits");
			for _,v in ipairs(nodeTraitsList) do
				if string.lower(DB.getText(DB.getChild(v, "name"))) == "size" then
					local stringSize =  DB.getText(DB.getChild(v, "text"));
					DB.setValue(nodeRace, "size", "string", stringSize);
				end
			end
		else
			local stringSize = DB.getText(nodeSize);
	end
end

function checkForAbilityScores(nodeRace)
	-- Validate parameters
	if not nodeRace then
		return nil;
	end
	
	-- Get the ability scores node
	local nodeAbility = DB.createChild(nodeRace, "abilityscores", "string");

	if not nodeAbility or DB.getValue(nodeAbility) == ""
		then
			--Get the ability scores trait
			local nodeTraitsList = DB.getChildList(nodeRace, "traits");
			for _,v in ipairs(nodeTraitsList) do
				if string.gsub(string.lower(DB.getText(DB.getChild(v, "name"))), "%s+", "") == "abilityscores" then
					local stringAbilityScores =  DB.getText(DB.getChild(v, "text"));
					DB.setValue(nodeRace, "abilityscores", "string", stringAbilityScores);
				end
			end
		else
			local stringAbilityScores = DB.getText(nodeAbility);
	end
end

function checkForVision(nodeRace)
	-- Validate parameters
	if not nodeRace then
		return nil;
	end
	
	-- Get the vision node
	local nodeVision = DB.createChild(nodeRace, "vision", "string");

	if not nodeVision or DB.getValue(nodeVision) == ""
		then
			--Get the vision trait
			local nodeTraitsList = DB.getChildList(nodeRace, "traits");
			for _,v in ipairs(nodeTraitsList) do
				if string.lower(DB.getText(DB.getChild(v, "name"))) == "vision" then
					local stringVision =  DB.getText(DB.getChild(v, "text"));
					DB.setValue(nodeRace, "vision", "string", stringVision);
				end
			end
		else
			local stringVision = DB.getText(nodeVision);
	end
end

function checkForLanguages(nodeRace)
	-- Validate parameters
	if not nodeRace then
		return nil;
	end
	
	-- Get the languages node
	local nodeLanguages = DB.createChild(nodeRace, "languages", "string");

	if not nodeLanguages or DB.getValue(nodeLanguages) == ""
		then
			--Get the languages trait
			local nodeTraitsList = DB.getChildList(nodeRace, "traits");
			for _,v in ipairs(nodeTraitsList) do
				if string.lower(DB.getText(DB.getChild(v, "name"))) == "languages" then
					local stringLanguages =  DB.getText(DB.getChild(v, "text"));
					DB.setValue(nodeRace, "languages", "string", stringLanguages);
				end
			end
		else
			local stringLanguages = DB.getText(nodeLanguages);
	end
end

function checkForSkillBonuses(nodeRace)
	-- Validate parameters
	if not nodeRace then
		return nil;
	end
	
	-- Get the skill bonuses node
	local nodeSkillBonuses = DB.createChild(nodeRace, "skillbonuses", "string");

	if not nodeSkillBonuses or DB.getValue(nodeSkillBonuses) == ""
		then
			--Get the skill bonuses trait
			local nodeTraitsList = DB.getChildList(nodeRace, "traits");
			for _,v in ipairs(nodeTraitsList) do
				if string.gsub(string.lower(DB.getText(DB.getChild(v, "name"))), "%s+", "") == "skillbonuses" then
					local stringSkillBonuses =  DB.getText(DB.getChild(v, "text"));
					DB.setValue(nodeRace, "skillbonuses", "string", stringSkillBonuses);
				end
			end
		else
			local stringSkillBonuses = DB.getText(nodeSkillBonuses);
	end
end