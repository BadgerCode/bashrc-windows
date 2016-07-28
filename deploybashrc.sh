#!/bin/bash

if [[ -z "$1" ]]; then
	echo "Pick an environment: laptop|desktop|default"
	echo "E.g. deploybashrc.sh default"
	exit
fi

bashEnv=$1

installPath="$HOME"
relSourcePath="`dirname \"$0\"`"
sourcePath="`( cd \"$relSourcePath\" && pwd )`"

if [[ -z "$sourcePath" ]] ; then
	echo "Error: I can't seem to access the directory where this script is located."
	exit 1
fi

if [[ -w ~/.bashrc ]]; then
	mv ~/.bashrc ~/.bashrc.old
	echo "Moved existing .bashrc to ~/.bashrc.old"
fi

cp "$sourcePath/bashrc" $installPath
mv "$installPath/bashrc" "$installPath/.bashrc"
echo "Deployed .bashrc"

if [[ $bashEnv == "laptop" ]]; then
	cat "$sourcePath/bashrc-laptop" >> "$installPath/.bashrc"
	echo "Deployed laptop environment specific bashrc"
elif [[ $bashEnv == "desktop" ]]; then
	cat "$sourcePath/bashrc-desktop" >> "$installPath/.bashrc"
	echo "Deployed desktop environment specific bashrc"
fi

printf "\n"
echo "Done. You will need to reload your bashrc file: source ~/.bashrc"
echo "Or if you already had this script: reloadbash"
