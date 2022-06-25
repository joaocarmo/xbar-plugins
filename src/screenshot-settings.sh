#!/usr/bin/env bash
# <bitbar.title>Screenshot Settings</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>João Carmo</bitbar.author>
# <bitbar.author.github>joaocarmo</bitbar.author.github>
# <bitbar.desc>Provides you with an easy way to change screenshot settings.</bitbar.desc>
# <bitbar.image>https://raw.githubusercontent.com/joaocarmo/xbar-plugins/main/assets/screenshot-settings-preview.png</bitbar.image>
# <bitbar.dependencies>bash</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/joaocarmo/xbar-plugins</bitbar.abouturl>
# <swiftbar.hideAbout>false</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>
# <swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>

DISABLE_SHADOWS=$(defaults read com.apple.screencapture disable-shadow 2>/dev/null)
TYPE=$(defaults read com.apple.screencapture type 2>/dev/null)

# Set the default values if they are not set
if [ -z "$DISABLE_SHADOWS" ]; then
    DISABLE_SHADOWS="false"
fi

if [ -z "$TYPE" ]; then
    TYPE="png"
fi

# Convert to bool
if [ "$DISABLE_SHADOWS" = "1" ]; then
    DISABLE_SHADOWS="true"
else
    DISABLE_SHADOWS="false"
fi

# Determine the new value
if [ "$1" = "disable-shadows" ]; then
    if [ "$DISABLE_SHADOWS" = "true" ]; then
        DISABLE_SHADOWS="false"
    else
        DISABLE_SHADOWS="true"
    fi
    defaults write com.apple.screencapture disable-shadow -bool $DISABLE_SHADOWS
    killall SystemUIServer
elif [ "$1" = "type" ]; then
    if [ "$TYPE" = "png" ]; then
        TYPE="jpg"
    else
        TYPE="png"
    fi
    defaults write com.apple.screencapture type $TYPE
    killall SystemUIServer
fi

SET_DISABLE_SHADOWS="$0 disable-shadows"
SET_TYPE="$0 type"

# Menu
echo ":camera:"
echo "---"
echo "Disable shadows: $DISABLE_SHADOWS | shell=$0 param1=disable-shadows terminal=false"
echo "Save as type: $TYPE | shell=$0 param1=type terminal=false"
