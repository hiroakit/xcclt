#!/bin/zsh

echo "Find Xcode Command Line Tools..."
XCLT_PATH=`xcode-select -p 2> /dev/null`
if [ $? -eq 0 ]; then
    echo "Found Xcode Command Line Tools on ${XCLT_PATH}"
    exit
fi

echo "Install Xcode Command Line Tools by softwareupdate"
SU_XCLT_FLUG_PATH=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
if [ ! -f ${SU_XCLT_FLUG_PATH} ]; then
    touch ${SU_XCLT_FLUG_PATH}
fi

XCLT_NAME=`softwareupdate -l | grep "Label: Command Line Tools" | awk -F': ' '{print $2}'`
if [ $? -ne 0 ]; then
    exit
fi

softwareupdate -i ${XCLT_NAME}
if [ -f ${SU_XCLT_FLUG_PATH} ]; then
    rm ${SU_XCLT_FLUG_PATH}
fi
