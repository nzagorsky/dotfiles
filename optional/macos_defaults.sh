set_defaults() {
	# Disable mouse scaling
	defaults write .GlobalPreferences com.apple.mouse.scaling -1

	# Command + Ctrl window movement
	defaults write -g NSWindowShouldDragOnGesture -bool false

	# Keep spaces arrangement
	defaults write com.apple.dock "mru-spaces" -bool "false"

	# Reduce motion to avoid sliding animations on desktop switch
	sudo defaults write com.apple.universalaccess reduceMotion -bool true

	# Finder: show hidden files by default
	defaults write com.apple.Finder AppleShowAllFiles -bool true

	# Enable spring loading for directories
	defaults write NSGlobalDomain com.apple.springing.enabled -bool true

	# Remove the spring loading delay for directories
	defaults write NSGlobalDomain com.apple.springing.delay -float 0

	# Speed up Mission Control animations. Doesn't work with Big Sur.
	defaults write com.apple.dock expose-animation-duration -float 0.1

	# Always show scrollbar
	defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

	# Speed up keyboard
	defaults write NSGlobalDomain KeyRepeat -int 1
	defaults write NSGlobalDomain InitialKeyRepeat -int 15
	defaults write -g ApplePressAndHoldEnabled -bool false

	# Finder: show path bar
	defaults write com.apple.finder ShowPathbar -bool true

	# Display full POSIX path as Finder window title
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

	# Keep folders on top when sorting by name
	defaults write com.apple.finder _FXSortFoldersFirst -bool true

	# When performing a search, search the current folder by default
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

	# Disable the warning when changing a file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

	# Avoid creating .DS_Store files on network or USB volumes
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

	# Dock: Change minimize/maximize window effect
	defaults write com.apple.dock mineffect -string "scale"

	# Dock: Minimize windows into their application's icon
	defaults write com.apple.dock minimize-to-application -bool true

	# Dock: Remove the auto-hiding Dock delay
	defaults write com.apple.dock autohide-delay -float 0

	# Dock: Remove the animation when hiding/showing the Dock
	defaults write com.apple.dock autohide-time-modifier -float 0

	# Dock: Automatically hide and show the Dock
	defaults write com.apple.dock autohide -bool true

	# Dock: Don't show recent applications in Dock
	defaults write com.apple.dock show-recents -bool false

	# Hot corners
	# Possible values:
	#  0: no-op
	#  2: Mission Control
	#  3: Show application windows
	#  4: Desktop
	#  5: Start screen saver
	#  6: Disable screen saver
	#  7: Dashboard
	# 10: Put display to sleep
	# 11: Launchpad
	# 12: Notification Center
	# 13: Lock Screen

	# Top left screen corner > Mission Control
	defaults write com.apple.dock wvous-tl-corner -int 2
	defaults write com.apple.dock wvous-tl-modifier -int 0
	# Top right screen corner > Desktop
	defaults write com.apple.dock wvous-tr-corner -int 0
	defaults write com.apple.dock wvous-tr-modifier -int 0
	# Bottom left screen corner > Start screen saver
	# defaults write com.apple.dock wvous-bl-corner -int 5
	# defaults write com.apple.dock wvous-bl-modifier -int 0

	# Show all processes in Activity Monitor
	defaults write com.apple.ActivityMonitor ShowCategory -int 0

}
