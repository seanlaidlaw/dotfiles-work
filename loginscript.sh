#!/usr/bin/env bash
if $(uname -a | grep -Fq Linux); then
	## Linux Specific Commands
	:
else
	## Mac specific Commands
	# http://homeowmorphism.com/articles/17/Remap-CapsLock-Backspace-Sierra

	# This script has been setup to run at login with the following cmd:
	# launchctl load ~/Library/LaunchAgents/com.user.loginscript.plist


	# Remap Caps lock key to backspace
	hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000002A}]}'

	# Reduce transparancy & animations

	# opening and closing windows and popovers
	defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

	# showing and hiding sheets, resizing preference windows, zooming windows
	# float 0 doesn't work
	defaults write -g NSWindowResizeTime -float 0.001

	# opening and closing Quick Look windows
	defaults write -g QLPanelAnimationDuration -float 0

	# resizing windows before and after showing the version browser
	# also disabled by NSWindowResizeTime -float 0.001
	defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false

	# showing a toolbar or menu bar in full screen
	defaults write -g NSToolbarFullScreenAnimationDuration -float 0

	# scrolling column views
	defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0

	# showing and hiding Mission Control, command+numbers
	defaults write com.apple.dock expose-animation-duration -float 0

	# at least AnimateInfoPanes
	defaults write com.apple.finder DisableAllAnimations -bool true
fi
