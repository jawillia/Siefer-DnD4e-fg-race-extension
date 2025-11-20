--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
	Options4ERaceExtension.registerOptions();
end

function registerOptions()
	OptionsManager.registerOptionData({
		sKey = "RACE_ABILITY_SCORE_VARIANTS", sGroupRes = "option_header_houserule",
		tCustom = 
		{ 
			labelsres = "option_val_RACE_ABILITY_SCORE_VARIANTS_no_restrictions|option_val_RACE_ABILITY_SCORE_VARIANTS_second_no_restrictions|option_val_RACE_ABILITY_SCORE_VARIANTS_first_half_second_no_restrictions", 
			values = "both_free|second_free|first_half_second_free", 
			baselabelres = "option_val_standard", 
			baseval = "", default = "", 
		},
	});
end
