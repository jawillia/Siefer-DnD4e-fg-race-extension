# Siefer-DnD4e-fg-race-extension

The beginnings of a DnD 4e extension for Fantasy Grounds that adds various capabilities from other rulesets that I want to see in the 4e one. This mostly includes creating other records and making them draggable onto the character sheet.

\#Release Notes  
v.0.1.0 - 04/13/2025 - Initial Release  
v.0.2.0 - 06/05/2025 - Added new tabs to the race library records. The second one is traits, with some fields, and ways to add more custom ones, and the third tab is for race-specific mechanical features and powers. They should be able to be dragged to the character sheet to add the features to the abilities tab and the powers to the powers tab.  
v.0.3.0 - 06/09/2025 - Added speed to character when race is drag-and-dropped on character main sheet.  
v.0.4.0 - 06/09/2025 - Added special movement, senses/vision, and languages to race information that is added when a race is drag-and-dropped on a character main sheet.  
v.0.5.0 - 06/11/2025 - Added skills and ability score bonuses to race information that is added when a race is drag-and-dropped on a character sheet. Skills are replaced when another race is added, ability score bonuses are not. If the race gives a choice between multiple ability scores, a dialogue box appears where you can select the one you want.  
v.0.6.0 - 06/17/2025 - Race bonuses should be able to parse better from description text, making it work better with older versions of the compendium module. Powers, features, etc are also no longer added when they already exist on the character. Racial ability score bonuses are reset when adding a new race.   
v0.6.1 - 10/06/2025 - Fixed racial skill bonuses not getting added to characters.   
v0.6.2 - 11/02/2025 - Fixed a bug preventing this extension from working with my DnD 4e Classes Extension.   
v0.6.3 - 11/10/2025 - Can now drag races onto the character's skill sheet, in addition to the main sheet.
v0.7.0 - 11/19/2025 - Add support for some house rules for racial ability scores: Standard, Both Free (no restrictions on both abiity scores), 2nd Free (meaning any default ability score for a race is given, and instead of the second choice you can pick any ability score), and 1st Half and 2nd Free (meaning the first ability score is half free - you can choose between any of usually 3 ability scores associated with that race - and the 2nd ability score chosen has no restrictions). Also should now parse ability score bonus for Humans correctly.

--------------------------
Instructions for Options
--------------------------
(House Rules)
Race: Ability Score Bonuses -
- Standard: Ability score bonuses are given as normal, as described in the race entries. Usually this means one ability score bonus given by default, and another abiity score bonus given as a choice between two different options.
- Both Free: Two ability score bonuses are given without restriction. You can choose from every ability score for a +2 bonus twice.
- 2nd Free: The first, usually default, ability score bonus is given as normal. Instead of a choice between two ability scores for your second choice, you can choose from all ability scores for this second bonus.
- 1st Half and 2nd Free: This means the first ability score is half restrictions and the 2nd ability score bonus has no restrictions. The first ability score bonus for a race is given as a choice between any ability score bonuses that race is associated with (usually 3, so the default one given and the two others given as a choice). The second ability bonus can be chosen from any of the ability scores.