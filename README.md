# DuffedUIv9
New Repository for WoW - Shadowlands

## Content
This repository currently contains the development version of DuffedUI for WoW - Shadowlands. **This version is not useable on the current WoW live servers!**

If you find bugs, and you will find them, please report them at the following URL:

==> [Issue Tracker for DuffedUI v9](https://github.com/liquidbase/DuffedUIv9/issues) <==

After Shadowlands is released, this repository will be converted to the live version.

## Informations for coding
All code that was inserted to continue to work during the PrePatch must be tagged with the following:

   --[[needs to be removed after release of Shadowlands]]--

This is to ensure that, after the release of Shadowlands, you can find the relevant jobs faster using the search term.

## Open Issues

## ToDo
- Testing

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
2020-08-25 | Fixed guild datatext by [Rav99](https://github.com/Rav99)<br />Fixed Aurora<br />Fixed alternate power by [Rav99](https://github.com/Rav99)<br />Fixed friend datatext by [Rav99](https://github.com/Rav99)<br />Removed system font
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