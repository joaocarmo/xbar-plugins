#!/usr/bin/env bash
# <bitbar.title>Screenshot Settings</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>João Carmo</bitbar.author>
# <bitbar.author.github>joaocarmo</bitbar.author.github>
# <bitbar.desc>Provides you with an easy way to change macOS' native screenshot settings.</bitbar.desc>
# <bitbar.image>https://raw.githubusercontent.com/joaocarmo/xbar-plugins/main/assets/screenshot-settings.png</bitbar.image>
# <bitbar.dependencies>bash</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/joaocarmo/xbar-plugins</bitbar.abouturl>
# <swiftbar.hideAbout>false</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>
# <swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>

FALSE="no"
TRUE="yes"

PNG="png"
JPEG="jpg"

DEFAULT_LOCATION="~/Desktop"

DISABLE_SHADOWS=$(defaults read com.apple.screencapture disable-shadow 2>/dev/null)
TYPE=$(defaults read com.apple.screencapture type 2>/dev/null)
LOCATION=$(defaults read com.apple.screencapture location 2>/dev/null)

# Set the default values if they are not set
if [ -z "$DISABLE_SHADOWS" ]; then
    DISABLE_SHADOWS=$FALSE
fi

if [ -z "$TYPE" ]; then
    TYPE=$PNG
fi

if [ -z "$LOCATION" ]; then
    LOCATION=$DEFAULT_LOCATION
fi

# Convert to bool
if [ "$DISABLE_SHADOWS" = "1" ]; then
    DISABLE_SHADOWS=$TRUE
else
    DISABLE_SHADOWS=$FALSE
fi

# Determine the new value
if [ "$1" = "disable-shadows" ]; then
    if [ "$DISABLE_SHADOWS" = $TRUE ]; then
        DISABLE_SHADOWS=$FALSE
    else
        DISABLE_SHADOWS=$TRUE
    fi
    defaults write com.apple.screencapture disable-shadow -bool $DISABLE_SHADOWS
    killall SystemUIServer
elif [ "$1" = "type" ]; then
    if [ "$TYPE" = $PNG ]; then
        TYPE=$JPEG
    else
        TYPE=$PNG
    fi
    defaults write com.apple.screencapture type $TYPE
    killall SystemUIServer
elif [ "$1" = "location" ]; then
    LOCATION=$(osascript -e 'set theOutputFolder to POSIX path of (choose folder with prompt "Please select a screenshot output folder")')
    defaults write com.apple.screencapture location $LOCATION
    killall SystemUIServer
fi

SET_DISABLE_SHADOWS="$0 disable-shadows"
SET_TYPE="$0 type"

# Menu
echo ":camera:"
echo "---"
echo "Disable shadows: $DISABLE_SHADOWS | shell=$0 param1=disable-shadows terminal=false"
echo "Save as type: $TYPE | shell=$0 param1=type terminal=false"
echo "Save to: $LOCATION | shell=$0 param1=location terminal=false"
