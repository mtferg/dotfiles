# .bashrc

unset VERSION
if [ -f /etc/bashrc ]; then . /etc/bashrc; fi

# User specific aliases and functions
command_exists() {
  if [ -z "$1" ]; then echo "Must pass argument to command_exists()"; return 1; fi
  command -v $1 >/dev/null 2>&1
}

alias ll='ls -lah'
alias df='df -h'
alias path='echo $PATH | tr ":" "\n"'
alias untar='tar -xvf'
alias rspec='rspec --color'
alias vs='vagrant status'
alias vu='vagrant up'
alias vssh='vagrant ssh'
alias vp='vagrant provision'
alias vh='vagrant halt'
alias vagrantfile='vim ~/.vagrant.d/Vagrantfile'
alias sneakyssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile /dev/null"'
alias dwc_env='. /etc/profile.d/dwc_env.sh'
alias tstart='thin -R config.ru start'
alias tf_clean='rm *.tfstate*'

# Add any other customizations
if [ -f ~/.bashrc_linux ]; then . ~/.bashrc_linux; fi
if [ -f ~/.bashrc_windows ]; then . ~/.bashrc_windows; fi
if [ -f ~/.bashrc_mac ]; then . ~/.bashrc_mac; fi
if [ -f ~/.bashrc_custom ]; then . ~/.bashrc_custom; fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -d "$HOME/.rvm/bin" ]; then export PATH="$PATH:$HOME/.rvm/bin" ; fi

# Custom Prompt

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\u:\[\e[36m\]\w\[\e[m\]:\[\e[33m\]\`parse_git_branch\`\[\e[m\]# "
