# DuffedUIv9
New Repository for WoW - Shadowlands

## Content
This repository currently contains the development version of DuffedUI for WoW - Shadowlands.

If you find bugs, and you will find them, please report them at the following URL:

==> [Issue Tracker for DuffedUI v9](https://github.com/liquidbase/DuffedUIv9/issues) <==

After Shadowlands is released, this repository will be converted to the live version.

## Open Issues

## ToDo
- Update oUF to new version

## Done
- Backdrops
- Popups
- Worldmaps
- Currencys
- Bank & Bags
- Functions
- Some Plugins
- Datatext
- ConfigUI
- Classcheck
- Actionbars
- Fixed left sidebar
- Groupframes finished
- Skinning enabled
- Debufffilter

## Changelog
Date | Change
--- | ---
2020-10-10 | Last preparation for release of the UI on 9.0.1<br />Removed not used funtion<br />Removed bag bar (not needed)<br />Removed range-display on target for better visibility of debuffs, target castbar and target<br />Added reset for SavedVars
2020-10-09 | Update Aurora
2020-10-07 | Correct width for XP-bar<br />Resied XP bar for better visbility
2020-10-06 | Moved local variable to update function
2020-10-05 | Removed duplicate local variables<br />Update for gold datatext by humfras
2020-10-04 | Added revision to afkcamera<br />Fixed missing concatenation<br />Added static popup to moveui-function
2020-10-03 | Update Aurora
2020-10-01 | Fixed auto invite
2020-09-28 | Update Aurora
2020-09-27 | Changed default value for buttons per row on bags and bank<br />Moved xp bar to the center datatext panel and removed options for xp bar<br />Moved azeritebar to bottom of minimap<br />Removed microbar<br />Removed rollffunction on copychat
2020-09-26 | Update Aurora<br />Fixed division by zero on durability display if no item is equipped
2020-09-25 | Added option to set size of debuffs on nameplates
2020-09-23 | Fixed itemdurability display on charscreen
2020-09-21 | Update Aurora<br />Removed button to open Helpticket on minimap
2020-09-18 | Update Aurora<br />Disabled HelpButton on minimap
2020-09-16 | toc-bump<br />Update Aurora
2020-09-13 | Update Aurora by [Rav99](https://github.com/Rav99)
2020-09-11 | Reorder Gold-DataText, Currencies now expansion specific
2020-09-10 | Update for Patch 9.0.2<br />toc-bump<br />Added missing currency<br />Removed entire corrupted system, no longer needed with 9.0.1 or later<br />Update gem info replacement, ignore slots from artifacts by [Rav99](https://github.com/Rav99)<br />Holy Power for all pallys by [Rav99](https://github.com/Rav99)<br />Official oUF rune fix by [Rav99](https://github.com/Rav99)Changed size of changelog-frame
2020-09-09 | Fixed idention on table<br />Refactoring core-scripts
2020-09-08 | Update Panels by [Rav99](https://github.com/Rav99)<br />Fix dt's tooltip on icenter by [Rav99](https://github.com/Rav99)<br />Removed old nameplate-folder and unnecessary code<br />Added Widget-Display to nameplates ==> needs testing <==<br />Moved nameplate-script to elements because nameplates are oUF-based and not stand alone
2020-09-07 | Added formerly removed systemfonts back to the UI<br />Fixed issue with chat mesg if guild member login or logoff
2020-09-06 | Added new SetFont-Function, Needs testing<br />Update SpecSwitcher by [Rav99](https://github.com/Rav99)<br />Fixed issue with instances and coords on map<br />Added removed system fonts in case they are updated again<br />Changed color from cooldowns on actionbars
2020-09-05 | Fixed issue with removed font<br />Moved debufflistings to more separate files<br />Fixed hoverbind, DuffedUI uses now the Quickbind-Function from Blizzard and commands works as known<br />Removed all keybind-commands, except /dkb, /dkb is the new command to trigger setup for keybinds<br />Attempt to fix AltPowerBar<br />Added new font for removed system font
2020-08-31 | Update for Aurora
2020-08-30 | Added different colors for currencies on backpack<br />Removed zero-values from currencies<br />Optimized currency function<br />Fixed size for currencies, 16x16 is too big<br />Removed currency from wrong section<br />Removed covenant specific currencies<br />Added new function for currencies<br />Added new currencies<br />Added correct visual style to chatbubbles via SetTemplate and localized config values<br />Better way too address config values<br />Update for Aurora
2020-08-29 | Update Chatbubbles by [Rav99](https://github.com/Rav99)<br />Fixed issue with optionvalue<br />Set font color for cooldowns on actionbars to white instead of red<br />Fixed invite function<br />Update dev.lua by [Rav99](https://github.com/Rav99)<br />Optionsmenu  by [Rav99](https://github.com/Rav99)
2020-08-28 | Added two new currencies
2020-08-27 | Fixed guild datatext by [Rav99](https://github.com/Rav99)<br />Fixed Aurora<br />Fixed alternate power by [Rav99](https://github.com/Rav99)<br />Fixed friend datatext by [Rav99](https://github.com/Rav99)<br />Removed system font
2020-08-24 | Added currency for Covenants
2020-08-26 | Pause are great!
2020-08-25 | Pause are great!
2020-08-24 | Added currency for Covenants
2020-08-23 | Added currency Infused Ruby<br />Update for Aurora<br />Added Currency<br />Added lib for widgets on nameplates and unitframes<br />Added functions for later usecase
2020-08-22 | Fixed jumping position of moving button for worldmap<br />Added automatic disable ffrom azerite bar<br />Added better way to hide azerite bar above 50<br />Added additional leveltext to tooltip on exp-bar on left chat<br />Moved rested icon to center of bar
2020-08-21 | Fixed Raid Debuff Filter<br />Removed a former fix for backdrops which tainted on shared frames
2020-08-20 | Fix map coords for newbee zones  by [Rav99](https://github.com/Rav99)
2020-08-19 | Fixed bagsorting for now, maybe a new bagscript will come
2020-08-18 | Fixed two spells<br />Update runes.lua by [Rav99](https://github.com/Rav99)<br />Update QuestIcon Lib by [Rav99](https://github.com/Rav99)<br />Debuff-filter update by [Rav99](https://github.com/Rav99)
2020-08-17 | Removed debuff from Legion raids and dungeons<br />Moved filter for Debuffs and Buffs<br />Update extraquestbutton by [Rav99](https://github.com/Rav99)<br />Moved classtimer from testing to correct position<br />Moved filterlists for classtimer<br />Fixed SavedVar-Value for versioncheck<br />Renamed frame for UIHider<br />Removed skinning functions no longer neededy<br />Added possibility to use the datatext in BfA<br />dt mission … by [Rav99](https://github.com/Rav99)<br />update locals by [Rav99](https://github.com/Rav99)<br />Fix lua error by [Rav99](https://github.com/Rav99)<br />Skin ConfigButton … by [Rav99](https://github.com/Rav99)<br />Added frames to kill in Display and Actionbar options on default Blizzard options<br />Fixed statusframe<br />Removed deprecated SkinFunc<br />Moved rangecheck filter to seperate file<br />Fixed AuraWatch-Function<br />Fixed buff tracking on raidframes<br />Update credits
2020-08-16 | Testing changes<br />Fixed versionscheck and rebuild the Versioning from DuffedUI
2020-08-15 | Removed Button no longer needed<br />Attempt to fix versioncheck<br />Apply changes for skinning with Aurora<br />Fixed temporary Aurora<br />Fixed icon position on actionbars<br />Removed remaining skins<br />Removed button for Enhanced_Config<br />Added Aurora for skin support
2020-08-14 | Removed second changelogscript<br />Disabled skins<br />Reenabled Skins<br />Fixed skin issue on system settings<br />Attempt 3rd to fix versioncheck<br />Set small Worldmap as default<br />Fixed backdrop ExtraActionButton
2020-08-13 | Fixed versioncheck<br />Fixed mapinfo<br />New attempt to fix missing buttons on left sidebar
2020-08-11 | Attempt to fix missing buttons on MultiBarBottomRight<br />Added vertical function to sidebars<br />Fixed loading für keybinds<br />Added customizable proc highlighting<br />Added mouseover to stance bar<br />Added vertical option to petbar<br />Added mouseover funtion to sidebars<br />Added vertical and mouseover function to rightbar<br />Added possibility to disable sidebars<br />Removed deprecated function<br />Fixed missed scaling for buttonsize on actionbars<br />Correct code ident<br />Added XML-Code for micromenu.lua<br />Fixed two locals
2020-08-10 | New code for actionbar, some parts are not finished<br />Removed current actionbar code for rebuild
2020-08-08 | Fixed objectivetracker<br />Fixed ressourcebar for mages<br />Fixed teleportmenu for mages<br />Fixed Division by zero on SlotDurability<br />Fixed ressourcebars for all classes<br />Removed old graphic from objectivetracker<br />Fixed UF-tag diffcolor<br />Fixed missing backdrops
2020-08-07 | Fixed Worldmap<br />Fixed StaticPopup to show not the border<br />Fixed bank and bags<br />Disabled Corruption-Plugins for Shadowlands (not needed anymore)<br />Fixed SpecSwitcher tooltip for current choosen talents<br />Fixed GetBackpackCurrencyInfo and removed two currencys<br />Fixed DataText BFA-Missons<br />Disabled UpdateKeybinds<br />Fixed GetCurrencyInfo()
2020-08-06 | UI initialized<br />Update .toc-files to match the new UI and Game version<br />Update Changelog with new informations<br />Added most of the backdrops<br />Setup fixed<br />Fixed threat indicator on raid, player and target<br />Fixed questicons on nameplates<br />Fixed Division by zero for power on playerframe<br />Fixed rangecheck
2020-08-06 | Repository initialized