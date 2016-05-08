#!/bin/bash

if [[ -z "$1" ]]; then
	echo "Pick an environment: laptop|desktop|default"
	echo "E.g. deploybashrc.sh default"
	exit
fi

bashEnv=$1

relPath="`dirname \"$0\"`"
absPath="`( cd \"$relPath\" && pwd )`"
if [[ -z "$absPath" ]] ; then
	echo "Error: I can't seem to access the directory where this script is located."
	exit 1
fi

if [[ -w ~/.bashrc ]]; then
	mv ~/.bashrc ~/.bashrc.old
	echo "Moved existing .bashrc to ~/.bashrc.old"
fi

cp "$absPath/.bashrc" ~/
echo "Deployed .bashrc"

if [[ $bashEnv == "laptop" ]]; then
	cat "$absPath/.bashrc-laptop" >> ~/.bashrc
	echo "Deployed laptop environment specific bashrc"
elif [[ $bashEnv == "desktop" ]]; then
	cat "$absPath/.bashrc-desktop" >> ~/.bashrc
	echo "Deployed desktop environment specific bashrc"
fi

echo "Done."
