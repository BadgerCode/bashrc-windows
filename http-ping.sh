#!/bin/bash

baseSite='http://www.google.com'
secondarySite='http://www.citymayhem.net'

function pingSite {
	site=$1
	timeInSeconds="$(curl -o /dev/null -s -w %{time_total}\\n $site)"
	timeInMs=$(echo $timeInSeconds | sed -r 's/([0-9]+)\.([0-9]+)/\1\2ms/' | sed -r 's/0*([0-9]+)/\1/')
	echo $timeInMs;
}

function getAndOutputSitePing {
	site=$1
	siteTime=$(pingSite $site)
	printf "$site: $siteTime "
}

echo "Pinging $baseSite & $secondarySite every 1 second"
printf "Press ctrl+c to cancel\n\n"

echo "Time taken:"

while true; do
	getAndOutputSitePing $baseSite

	printf "\t\t"
	getAndOutputSitePing $secondarySite

	printf "\n"
	sleep 1
done
