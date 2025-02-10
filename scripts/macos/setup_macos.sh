#! /usr/bin/env bash
set -euxo pipefail

# MacOS Settings(NOTE: Required Disk Permission)
# defaults CLI
## Dock
defaults write com.apple.dock autohide -bool true &&
  defaults write com.apple.dock no-bouncing -bool TRUE &&
  defaults write com.apple.dock autohide-delay -float 0 &&
  defaults write com.apple.dock show-recents -bool false && killall Dock

## disable generate .DS_Store
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

## screencapture
defaults write com.apple.screencapture name ""

## show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder

## key settings
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

## disable text cursor (macos sonoma)
defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled 0

## disable swipescrolldirection
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

## disable spotlight
### https://gist.github.com/adamstac/1249295
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

## AutoHide MenuBar(Terminal Restaat Required)
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# apply dark mode
## https://simonewebdesign.it/how-to-enable-dark-mode-macos-command-line/
osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
