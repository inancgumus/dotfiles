#!/bin/bash

#
# NOTE: Never redirect commands to /dev/null
#       Run them using `runCmd()`.
#       For multiple commands use `runCmdNONL`.
#
#       NONL means No Newline
#

###############################################################################
# Configs                                                                     #
###############################################################################
STANDBY_DELAY=3600

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until '.osx' has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# General UI/UX                                                               #
###############################################################################

infoHead "UI/UX"

# info "Setting computer name\c"
# sudo scutil --set ComputerName $DEFAULT_COMPUTER_NAME
# sudo scutil --set HostName $DEFAULT_COMPUTER_NAME
# sudo scutil --set LocalHostName $DEFAULT_COMPUTER_NAME

# info "Set standby delay to 24 hours (default is 1 hour)\c"
# runCmd sudo pmset -a standbydelay $STANDBY_DELAY

info "Setmenu extras\c"
runCmd defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Clock.menu"

info "Set highlight color to green\c"
runCmd defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

info "Set sidebar icon size to medium\c"
runCmd defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

info "Always show scrollbars\c"
runCmd defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
# Possible values: 'WhenScrolling', 'Automatic' and 'Always'

info "Increase window resize speed for Cocoa applications\c"
runCmd defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

info "Expand save panel by default\c"
runCmdNONL defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
runCmd defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

info "Expand print panel by default\c"
runCmdNONL defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
runCmd defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

info "Save to disk (not to iCloud) by default\c"
runCmd defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

info "Automatically quit printer app once the print jobs complete\c"
runCmd defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

info "Disable the “Are you sure you want to open this application?” dialog\c"
runCmd defaults write com.apple.LaunchServices LSQuarantine -bool false

info "Remove duplicates in the “Open With” menu (also see 'lscleanup' alias)\c"
runCmd /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

info "Display ASCII control characters using caret notation in standard text views\c"
# Try e.g. 'cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt'
runCmd defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

info "Enable Resume system-wide\c"
runCmd defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool true

info "Automatic termination of inactive apps\c"
runCmd defaults write NSGlobalDomain NSDisableAutomaticTermination -bool false

info "Disable the crash reporter\c"
runCmd defaults write com.apple.CrashReporter DialogType -string "none"

info "Set Help Viewer windows to non-floating mode\c"
runCmd defaults write com.apple.helpviewer DevMode -bool true

# Fix for the ancient UTF-8 bug in QuickLook (https://mths.be/bbo)
# Commented out, as this is known to cause problems in various Adobe apps :(
# See https://github.com/mathiasbynens/dotfiles/issues/237
#echo "0x08000100:0" > ~/.CFUserTextEncoding

info "Restart automatically if the computer freezes\c"
# sudo systemsetup -setrestartfreeze on

# Never go into computer sleep mode
# sudo systemsetup -setcomputersleep Off

# Check for software updates daily, not just once per week
runCmd defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# info "Disable Notification Center and remove the menu bar icon\c"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

info "Disable smart quotes as they’re annoying when typing code\c"
runCmd defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

info "Disable smart dashes as they’re annoying when typing code\c"
runCmd defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# info "Set a custom wallpaper image.\c"
# 'DefaultDesktop.jpg' is already a symlink, and
# all wallpapers are in '/Library/Desktop Pictures/'. The default is 'Wave.jpg'.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################

infoHead "SSD"

# info "Disable hibernation (speeds up entering sleep mode)\c"
# sudo pmset -a hibernatemode 0

# info "Remove the sleep image file to save disk space\c"
# sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
# sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
# sudo chflags uchg /private/var/vm/sleepimage

info "Disable the sudden motion sensor as it’s not useful for SSDs\c"
runCmd sudo pmset -a sms 0

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

infoHead "TRACKPAD"

info "Enable tap to click for this user and for the login screen\c"
runCmdNONL defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
runCmd defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

info "\tNSGlobalDomain com.apple.mouse.tapBehavior\c"
runCmd defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

info "\tcom.apple.driver.AppleBluetoothMultitouch.trackpad\c"
runCmd defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0

info "\tcom.apple.driver.AppleBluetoothMultitouch.trackpad\c"
runCmd defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

info "\tNSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior\c"
runCmd defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1

info "\tNSGlobalDomain com.apple.trackpad.enableSecondaryClick\c"
runCmd defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

info "\tDragLock\c"
runCmd defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool false

info "\tDragging\c"
runCmd defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true

info "Disable “natural” (Lion-style) scrolling\c"
runCmd defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

info "Increase sound quality for Bluetooth headphones/headsets\c"
runCmd defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

info "Enable full keyboard access for all controls\c"
# (e.g. enable Tab in modal dialogs)
runCmd defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

info "Use scroll gesture with the Cmd + Opt modifier key to zoom\c"
runCmdNONL defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
runCmd defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 1179648

info "Do not follow the keyboard focus while zoomed in\c"
runCmd defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool false

info "Disable press-and-hold for keys in favor of key repeat\c"
runCmd defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

info "Set keyboard repeat rate to 2\c"
runCmd defaults write NSGlobalDomain KeyRepeat -int 2

info "Set keyboard initial repeat rate to 25\c"
runCmd defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Note: if you’re in the US, replace 'EUR' with 'USD', 'Centimeters' with
# 'Inches', 'en_GB' with 'en_US', and 'true' with 'false'.
info "Set language to tr\c"
runCmd defaults write NSGlobalDomain AppleLanguages -array en tr
info "Set currency to try\c"
runCmd defaults write NSGlobalDomain AppleLocale -string "en_TR@currency=TRY"
info "Set measurement unit to centimeters\c"
runCmd defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
info "Set metrics unit to meter\c"
runCmd defaults write NSGlobalDomain AppleMetricUnits -bool true

# info "Set the timezone; see 'sudo systemsetup -listtimezones' for other values\c"
# sudo systemsetup -settimezone "Europe/Istanbul"

info "Disable auto-correct\c"
runCmd defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

info "Stop iTunes from responding to the keyboard media keys\c"
runCmd launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist


###############################################################################
# Screen                                                                      #
###############################################################################

infoHead "SCREEN"

info "Require password after sleep or screen saver begins\c"
runCmd defaults write com.apple.screensaver askForPassword -int 1
info "Require password immediately\c"
runCmd defaults write com.apple.screensaver askForPasswordDelay -int 0

info "Save screenshots to the desktop\c"
runCmd defaults write com.apple.screencapture location -string "${HOME}/Desktop"

info "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)\c"
runCmd defaults write com.apple.screencapture type -string "png"

info "Disable shadow in screenshots\c"
runCmd defaults write com.apple.screencapture disable-shadow -bool true

info "Enable subpixel font rendering on non-Apple LCDs\c"
runCmd defaults write NSGlobalDomain AppleFontSmoothing -int 2

info "Enable HiDPI display modes (requires restart)\c"
runCmd defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

infoHead "FINDER"

info "Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons\c"
runCmd defaults write com.apple.finder QuitMenuItem -bool true

info "Finder: disable window animations and Get Info animations\c"
runCmd defaults write com.apple.finder DisableAllAnimations -bool true

info "Set Desktop as the default location for new Finder windows\c"
# For other paths, use 'PfLo' and 'file:///full/path/here/'
runCmdNONL defaults write com.apple.finder NewWindowTarget -string "PfDe"
runCmd defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

info "Show icons for external hard drives on the desktop\c"
runCmd defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
info "Show icons for hard drives on the desktop\c"
runCmd defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
info "Show icons for mounted servers on the desktop\c"
runCmd defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
info "Show icons for removable media on the desktop\c"
runCmd defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

info "Finder: show hidden files by default\c"
runCmd defaults write com.apple.finder AppleShowAllFiles -bool true

info "Finder: show all filename extensions\c"
runCmd defaults write NSGlobalDomain AppleShowAllExtensions -bool true

info "Finder: show status bar\c"
runCmd defaults write com.apple.finder ShowStatusBar -bool true

info "Finder: show path bar\c"
runCmd defaults write com.apple.finder ShowPathbar -bool true

info "Finder: allow text selection in Quick Look\c"
runCmd defaults write com.apple.finder QLEnableTextSelection -bool true

info "Display full POSIX path as Finder window title\c"
runCmd defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

info "When performing a search, search the current folder by default\c"
runCmd defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

info "Disable the warning when changing a file extension\c"
runCmd defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

info "Enable spring loading for directories\c"
runCmd defaults write NSGlobalDomain com.apple.springing.enabled -bool true

info "Remove the spring loading delay for directories\c"
runCmd defaults write NSGlobalDomain com.apple.springing.delay -float 0

info "Avoid creating .DS_Store files on network volumes\c"
runCmd defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

info "Disable disk image verification\c"
runCmd defaults write com.apple.frameworks.diskimages skip-verify -bool true
info "Disable disk image verification: locked\c"
runCmd defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
info "Disable disk image verification: remote\c"
runCmd defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

info "Automatically open a new Finder window when a volume is mounted\c"
runCmd defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
info "Automatically open a new Finder window when a volume is mounted: rw root\c"
runCmd defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
info "Automatically open a new Finder window when a volume is mounted: removable disk\c"
runCmd defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true


info "Show item info near icons on the desktop and in other icon views\c"
runCmd /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
info "Show item info near icons on the desktop and in other icon views: icon\c"
runCmd /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
info "Show item info near icons on the desktop and in other icon views: standard view\c"
runCmd /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist


info "Show item info to the right of the icons on the desktop\c"
runCmd /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

info "Enable snap-to-grid for icons on the desktop and in other icon views\c"
runCmdNONL /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
runCmdNONL /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
runCmd /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


info "Increase grid spacing for icons on the desktop and in other icon views\c"
runCmdNONL /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
runCmdNONL /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
runCmd /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

info "Increase the size of icons on the desktop and in other icon views\c"
runCmdNONL /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
runCmdNONL /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
runCmd /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

info "Use list view in all Finder windows by default\c"
# Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv'
runCmd defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

info "Disable the warning before emptying the Trash\c"
runCmd defaults write com.apple.finder WarnOnEmptyTrash -bool false

info "Empty Trash securely by default\c"
runCmd defaults write com.apple.finder EmptyTrashSecurely -bool false

info "Enable AirDrop over Ethernet and on unsupported Macs running Lion\c"
runCmd defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Enable the MacBook Air SuperDrive on any Mac
# sudo nvram boot-args="mbasd=1"

info "Show the ~/Library folder\c"
runCmd chflags nohidden ~/Library

info "Expand the following File Info panes: “General”, “Open with”, and “Sharing & Permissions”\c"
runCmd defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

info "Increase the size of icons on the desktop and in other icon views\c"
runCmdNONL /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
runCmdNONL /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
runCmd /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

infoHead "DOCK, DASHBOARD, AND HOT CORNERS"

info "Enable highlight hover effect for the grid view of a stack (Dock)\c"
runCmd defaults write com.apple.dock mouse-over-hilite-stack -bool true

info "Set the icon size of Dock items to 36 pixels\c"
runCmd defaults write com.apple.dock tilesize -int 118

info "Change minimize/maximize window effect\c"
runCmd defaults write com.apple.dock mineffect -string "scale"

info "Minimize windows into their application’s icon\c"
runCmd defaults write com.apple.dock minimize-to-application -bool true

info "Enable spring loading for all Dock items\c"
runCmd defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

info "Show indicator lights for open applications in the Dock\c"
runCmd defaults write com.apple.dock show-process-indicators -bool true

info "Wipe all (default) app icons from the Dock\c"
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
runCmd defaults write com.apple.dock persistent-apps -array

info "Don’t animate opening applications from the Dock\c"
runCmd defaults write com.apple.dock launchanim -bool false

info "Speed up Mission Control animations\c"
runCmd defaults write com.apple.dock expose-animation-duration -float 0.1

info "Don’t group windows by application in Mission Control\c"
runCmd defaults write com.apple.dock expose-group-by-app -bool false

info "Disable Dashboard\c"
runCmd defaults write com.apple.dashboard mcx-disabled -bool true

info "Don’t show Dashboard as a Space\c"
runCmd defaults write com.apple.dock dashboard-in-overlay -bool true

info "Don’t automatically rearrange Spaces based on most recent use\c"
runCmd defaults write com.apple.dock mru-spaces -bool false

info "Remove the auto-hiding Dock delay\c"
runCmd defaults write com.apple.dock autohide-delay -float 0
info "Adjust the animation when hiding/showing the Dock\c"
runCmd defaults write com.apple.dock autohide-time-modifier -float 0.5

info "Automatically hide and show the Dock\c"
runCmd defaults write com.apple.dock autohide -bool true

info "Make Dock icons of hidden applications translucent\c"
runCmd defaults write com.apple.dock showhidden -bool true

info "Disable the Launchpad gesture (pinch with thumb and three fingers)\c"
runCmd defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

info "Reset Launchpad, but keep the desktop wallpaper intact\c"
runCmd find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# info "Add a spacer to the left side of the Dock (where the applications are)\c"
# runCmd defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

# info "Add a spacer to the right side of the Dock (where the Trash is)\c"
# runCmd defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'


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
# Top left screen corner → Mission Control
info "Configure hot corners: top left to mission control\c"
runCmdNONL defaults write com.apple.dock wvous-tl-corner -int 2
runCmd defaults write com.apple.dock wvous-tl-modifier -int 0

info "Configure hot corners: top right to show application windows\c"
runCmdNONL defaults write com.apple.dock wvous-tr-corner -int 3
runCmd defaults write com.apple.dock wvous-tr-modifier -int 0

info "Configure hot corners: bottom left to put display on sleep\c"
runCmdNONL defaults write com.apple.dock wvous-bl-corner -int 10
runCmd defaults write com.apple.dock wvous-bl-modifier -int 0

info "Configure hot corners: bottom right to show desktop\c"
runCmdNONL defaults write com.apple.dock wvous-br-corner -int 4
runCmd defaults write com.apple.dock wvous-br-modifier -int 0


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

infoHead "SAFARI & WEBKIT"

info "Privacy: don’t send search queries to Apple\c"
runCmd defaults write com.apple.Safari UniversalSearchEnabled -bool false
info "Privacy: don’t send search suggestions to Apple\c"
runCmd defaults write com.apple.Safari SuppressSearchSuggestions -bool true

info "Press Tab to highlight each item on a web page\c"
runCmdNONL defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
runCmd defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

info "Show the full URL in the address bar (note: this still hides the scheme)\c"
runCmd defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

info "Set Safari’s home page to 'about:blank' for faster loading\c"
runCmd defaults write com.apple.Safari HomePage -string "about:blank"

info "Prevent Safari from opening ‘safe’ files automatically after downloading\c"
runCmd defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

info "Allow hitting the Backspace key to go to the previous page in history\c"
runCmd defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

info "Hide Safari’s bookmarks bar by default\c"
runCmd defaults write com.apple.Safari ShowFavoritesBar -bool false

info "Hide Safari’s sidebar in Top Sites\c"
runCmd defaults write com.apple.Safari ShowSidebarInTopSites -bool false

info "Disable Safari’s thumbnail cache for History and Top Sites\c"
runCmd defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

info "Enable Safari’s debug menu\c"
runCmd defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

info "Make Safari’s search banners default to Contains instead of Starts With\c"
runCmd defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

info "Remove useless icons from Safari’s bookmarks bar\c"
runCmd defaults write com.apple.Safari ProxiesInBookmarksBar "()"

info "Enable the Develop menu and the Web Inspector in Safari\c"
runCmdNONL defaults write com.apple.Safari IncludeDevelopMenu -bool true
runCmdNONL defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
runCmd defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

info "Add a context menu item for showing the Web Inspector in web views\c"
runCmd defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

infoHead "APPLE MAIL"

info "Disable reply animations in Mail.app\c"
runCmd defaults write com.apple.mail DisableReplyAnimations -bool true
info "Disable send animations in Mail.app\c"
runCmd defaults write com.apple.mail DisableSendAnimations -bool true

info "Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app\c"
runCmd defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

info "Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app\c"
runCmd defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

info "Display emails in threaded mode, sorted by date (oldest at the top)\c"
runCmdNONL defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
runCmdNONL defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
runCmd defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

info "Disable inline attachments (just show the icons)\c"
runCmd defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

info "Disable automatic spell checking\c"
runCmd defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"


###############################################################################
# Spotlight                                                                   #
###############################################################################

# info "Hide Spotlight tray-icon (and subsequent helper)\c"
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

infoHead "SPOTLIGHT"

info "Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed before.\c"
# Use 'sudo mdutil -i off "/Volumes/foo"' to stop indexing any volume.
runCmd defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
info "Change indexing order and disable some search results\c"
runCmd defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

info "Load new settings before rebuilding the index\c"
runCmd killall mds

info "Make sure indexing is enabled for the main volume\c"
runCmd sudo mdutil -i on /

info "Rebuild the index from scratch\c"
runCmd sudo mdutil -E /

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

info "Only use UTF-8 in Terminal.app\c"
runCmd defaults write com.apple.terminal StringEncodings -array 4

info "Enable “focus follows mouse” for Terminal.app and all X11 apps\c"
# i.e. hover over a window and start typing in it without clicking first
runCmdNONL defaults write com.apple.terminal FocusFollowsMouse -bool true
runCmd defaults write org.x.X11 wm_ffm -bool true

# info "Install the Solarized Dark theme for iTerm\c"
# open "${dotfiles}/iterm/Solarized Dark.itermcolors"

info "Don’t display the annoying prompt when quitting iTerm\c"
runCmd defaults write com.googlecode.iterm2 PromptOnQuit -bool false


###############################################################################
# Time Machine                                                                #
###############################################################################

# info "Prevent Time Machine from prompting to use new hard drives as backup volume\c"
# runCmd defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# info "Disable local Time Machine backups\c"
# hash tmutil &> /dev/null && sudo tmutil disablelocal


###############################################################################
# Activity Monitor                                                            #
###############################################################################

info "Show the main window when launching Activity Monitor\c"
runCmd defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

info "Visualize CPU usage in the Activity Monitor Dock icon\c"
runCmd defaults write com.apple.ActivityMonitor IconType -int 5

info "Show all processes in Activity Monitor\c"
runCmd defaults write com.apple.ActivityMonitor ShowCategory -int 0

info "Sort Activity Monitor results by CPU usage\c"
runCmdNONL defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
runCmd defaults write com.apple.ActivityMonitor SortDirection -int 0


###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

info "Enable the debug menu in Address Book\c"
runCmd defaults write com.apple.addressbook ABShowDebugMenu -bool true

info "Enable Dashboard dev mode (allows keeping widgets on the desktop)\c"
runCmd defaults write com.apple.dashboard devmode -bool true

info "Enable the debug menu in iCal (pre-10.8)\c"
runCmd defaults write com.apple.iCal IncludeDebugMenu -bool true

info "Use plain text mode for new TextEdit documents\c"
runCmd defaults write com.apple.TextEdit RichText -int 0

info "Open and save files as UTF-8 in TextEdit\c"
runCmdNONL defaults write com.apple.TextEdit PlainTextEncoding -int 4
runCmd defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

info "Enable the debug menu in Disk Utility\c"
runCmdNONL defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
runCmd defaults write com.apple.DiskUtility advanced-image-options -bool true


###############################################################################
# Mac App Store                                                               #
###############################################################################

info "Enable the WebKit Developer Tools in the Mac App Store\c"
runCmd defaults write com.apple.appstore WebKitDeveloperExtras -bool true

info "Enable Debug Menu in the Mac App Store\c"
runCmd defaults write com.apple.appstore ShowDebugMenu -bool true


###############################################################################
# Messages                                                                    #
###############################################################################

infoHead "APPLE MESSAGES"

info "Disable automatic emoji substitution (i.e. use plain text smileys)\c"
runCmd defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

info "Disable smart quotes as it’s annoying for messages that contain code\c"
runCmd defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

info "Disable continuous spell checking\c"
runCmd defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false


###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

info "Allow installing user scripts via GitHub Gist or Userscripts.org\c"
runCmdNONL defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"
runCmd defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"

info "Disable the all too sensitive backswipe on trackpads\c"
runCmdNONL defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
runCmd defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

info "Disable the all too sensitive backswipe on Magic Mouse\c"
runCmdNONL defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
runCmd defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

info "Use the system-native print preview dialog\c"
runCmdNONL defaults write com.google.Chrome DisablePrintPreview -bool true
runCmd defaults write com.google.Chrome.canary DisablePrintPreview -bool true

info "Expand the print dialog by default\c"
runCmdNONL defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
runCmd defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true


###############################################################################
# GPGMail 2                                                                   #
###############################################################################

info "Disable signing emails by default\c"
runCmd defaults write ~/Library/Preferences/org.gpgtools.gpgmail SignNewEmailsByDefault -bool false


###############################################################################
# SizeUp.app                                                                  #
###############################################################################

infoHead "SizeUp.app"

info "Start SizeUp at login\c"
runCmd defaults write com.irradiatedsoftware.SizeUp StartAtLogin -bool true

info "Don’t show the preferences window on next start\c"
runCmd defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false



infoHead "Transmission.app"

info "Use '~/Documents/Torrents' to store incomplete downloads\c"
runCmdNONL defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
runCmdNONL touch -f "${HOME}/Downloads/Torrents"
runCmd defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Torrents"

info "Don’t prompt for confirmation before downloading\c"
runCmd defaults write org.m0k.transmission DownloadAsk -bool false

info "Trash original torrent files\c"
runCmd defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

info "Hide the donate message\c"
runCmd defaults write org.m0k.transmission WarningDonate -bool false

info "Hide the legal disclaimer\c"
runCmd defaults write org.m0k.transmission WarningLegal -bool false


infoHead "TWITTER"

info "Disable smart quotes as it’s annoying for code tweets\c"
runCmd defaults write com.twitter.twitter-mac AutomaticQuoteSubstitutionEnabled -bool false

info "Show the app window when clicking the menu bar icon\c"
runCmd defaults write com.twitter.twitter-mac MenuItemBehavior -int 1

info "Enable the hidden ‘Develop’ menu\c"
runCmd defaults write com.twitter.twitter-mac ShowDevelopMenu -bool true

info "Open links in the background\c"
runCmd defaults write com.twitter.twitter-mac openLinksInBackground -bool true

info "Allow closing the ‘new tweet’ window by pressing Esc\c"
runCmd defaults write com.twitter.twitter-mac ESCClosesComposeWindow -bool true

info "Show full names rather than Twitter handles\c"
runCmd defaults write com.twitter.twitter-mac ShowFullNames -bool true

info "Hide the app in the background if it’s not the front-most window\c"
runCmd defaults write com.twitter.twitter-mac HideInBackground -bool true


infoHead "KILLING AFFECTED APPS"

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Google Chrome" "Mail" "Messages" \
	"Opera" "Safari" "SizeUp" "Spectacle" "SystemUIServer" \
	"Transmission" "Twitter" "iCal"; do
	info "\t${app}...\c"
	runCmd killall "${app}"
done

echo