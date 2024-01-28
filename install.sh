#!/bin/zsh

echo "Find Xcode Command Line Tools..."
XCLT_PATH=`xcode-select -p`
if [ $? -eq 0 ]; then
  echo "Found Xcode Command Line Tools on ${XCLT_PATH}"
  exit 0
fi

echo "Install Xcode Command Line Tools by 'xcode-select --install'"
xcode-select --install
osascript > /dev/null << APPLESCRIPT
-- Waiting appear "Install Command Line Developer Tools" dialog
delay 5

tell application "Install Command Line Developer Tools"
	activate
	
	tell application "System Events" to tell window 1 of application process "Install Command Line Developer Tools"
		activate
		
		-- 1:Install button, 2:Cancel button
		click button 1
		
		delay 1.5
		
		-- On "License Agreement" modal window
		-- 1:Agree button, 2:UnAgree button
		click button 1
	end tell
end tell
APPLESCRIPT
