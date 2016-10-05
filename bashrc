# Start bash in home (probably better way to do this)
cd

# HTTP Ping
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

function httpping {
	baseSite='http://www.google.com'
	unset secondarySite

	if [[ -z "$1" ]]; then
		printf "You can specify a second site to ping with:\nhttpping http://mysite.com\n\n"
		echo "Pinging $baseSite every 1 second"
	else
		secondarySite=$1
		echo "Pinging $baseSite & $secondarySite every 1 second"
	fi

	printf "Press ctrl+c to cancel\n\n"

	echo "Time taken:"

	while true; do
		getAndOutputSitePing $baseSite

		if [[ -n $secondarySite ]]; then
			printf "\t\t"
			getAndOutputSitePing $secondarySite
		fi

		printf "\n"
		sleep 1
	done
}

# General unix
alias reloadbash="source ~/.bashrc; cd -"
export -f httpping

# General windows
alias here="start ."
alias npp="start /c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe"
alias vis="find . -name *.sln | xargs -n 1 start"
alias msbuild="/c/Windows/Microsoft.NET/Framework64/v4.0.30319/msbuild.exe"
alias mysql="winpty 'C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe'"

# Git
# Config
git config --global user.email "BadgerCode@users.noreply.github.com"
git config --global user.name "Michael Hawkins"
git config --global core.askpass ''
# Aliases
alias gs="git status"
alias gaa="git add -A"
alias gc="git commit -m"
alias gd="git diff"
alias gp="git push"

