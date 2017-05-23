#!/bin/sh
set -e
echo "Setting up BYOND."
mkdir -p "$HOME/BYOND-${BYOND_MAJOR}.${BYOND_MINOR}"
cd "$HOME/BYOND-${BYOND_MAJOR}.${BYOND_MINOR}"
echo "Installing DreamMaker to $PWD"
curl "http://www.byond.com/download/build/${BYOND_MAJOR}/${BYOND_MAJOR}.${BYOND_MINOR}_byond_linux.zip" -o byond.zip
unzip -o byond.zip
cd byond
make here
chmod a+x bin/DreamDaemon
chmod a+x bin/DreamMaker
