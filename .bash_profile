# .bash_profile

# ChefVM (https://github.com/trobrock/chefvm)
if [ -d ~/.chefvm ]; then eval "$(~/.chefvm/bin/chefvm init -)" ; fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then . ~/.bashrc ; fi
if [ -f ~/.bash_secrets ]; then . ~/.bash_secrets ; fi
if [ -f ~/.bash_profile_mac ]; then . ~/.bash_profile_mac ; fi
if [ -f ~/.bash_profile_custom ]; then . ~/.bash_profile_custom ; fi
if [ -f ~/bin/proxy ]; then . ~/bin/proxy ; fi

# User specific environment and startup programs

if [ -d "$HOME/bin" ]; then PATH="$PATH:$HOME/bin" ; fi
if [ -d "/usr/local/go/bin" ]; then PATH="$PATH:/usr/local/go/bin"; fi
export PATH

# Change dir color (awful blue) of ls command
LS_COLORS=$LS_COLORS:'di=0;36:' ; export LS_COLORS

# Load ssh key
if [ -f ~/.ssh/id_rsa ]; then
  eval "$(ssh-agent -s)" > /dev/null
  ssh-add ~/.ssh/id_rsa > /dev/null
fi

# Chef Ruby Path:
# eval "$(chef shell-init bash)"


# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
