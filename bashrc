# To start bash in a specific directory by default in Windows, right click the shortcut and set the start in location
# The shortcut will probably be located in your own appdata, so it's fine to hardcode it to your own personal user folder

# HTTP Ping
function pingSite {
	site=$1
	timeInSeconds="$(curl -o /dev/null -s -w %{time_total}\\n $site)"
	timeInMs=$(echo $timeInSeconds | sed -r 's/^.*([0-9]+)\.([0-9]{0,3}).*$/\1\2ms/' | sed -r 's/0*(([1-9][0-9]*)?[0-9]ms)/\1/' )
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

function gitprune {
	if [[ -z "$1" ]]; then
		printf "Please specify master branch name. EVERY merged local branch apart from the master branch will be DELETED. e.g. gitprune master\n"
		return;
	fi

	master=$1
	currentBranch=$(git rev-parse --abbrev-ref HEAD)

	if [ "$currentBranch" != "$master" ]; then
		printf "Please checkout your master branch first.\n"
		return;
	fi

	printf "Pruning remote branches that no longer exist...\n"
	git remote prune origin
	branches=$(git branch --merged | grep -v $master)

	if [[ -z "$branches" ]]; then
		printf "No local merged branches to delete.\n"
		return;
	fi

	printf "Pruning local merged branches...\n"
	echo $branches | xargs git branch -d
}

function gitremote {
	remote=$1

	if [[ -z "$remote" ]]; then
		remote="origin"
	fi

	url=$(git remote get-url origin)

	if [[ $url == *"github"* ]]; then
		echo $url | sed 's/git@github.com:\(.*\)\.git/https:\/\/github.com\/\1/' | xargs start
	elif [[ $url == *"dev.azure.com"* ]]; then
		echo $url |  sed 's/.*@.*dev.azure.com:[a-z0-9]*\/\(.*\)\/\(.*\)/https:\/\/dev.azure.com\/\1\/_git\/\2/' | xargs start
	elif [[ $url == *"visualstudio.com"* ]]; then
		echo $url |  sed 's/.*@vs-ssh.visualstudio.com:[a-z0-9]*\/\(.*\)\/\(.*\)/https:\/\/dev.azure.com\/\1\/_git\/\2/' | xargs start
	else
		echo "Unknown remote repo- '${url}''"
	fi
}

alias github="gitremote"
alias devops="gitremote"

function pr {
	branch=$(git branch | grep "\* " | sed 's/\* \(.*\)/\1/')

		if [[ -z "$branch" ]]; then
			printf "Could not get active branch"
			return;
		fi

	baseUrl=$(git remote get-url origin | sed 's/git@github.com:\(.*\)\.git/https:\/\/github.com\/\1\/compare\//')
	echo "$baseUrl$branch" | xargs start
}

# General unix
alias reloadbash="source ~/.bashrc"
export -f httpping

# General windows
alias here="start ."
alias vis="find . -name \"*.sln\" -not -path '*/node_modules/*' | xargs -n 1 start"
alias map="find . -name \"*.vmf\" | xargs -n 1 start" # Source SDK Hammer
alias vscode="code ."

# Git
# Config
git config --global user.email "BadgerCode@users.noreply.github.com"
git config --global user.name "Michael Hawkins"
git config --global core.askpass ''

# Aliases
alias gs="git status"
alias gaa="git add -A"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gd="git diff"
alias gp="git push"
alias gitbranch="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

