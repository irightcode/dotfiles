source_if_exists () {
	if test -r "$1"; then
		source "$1"
	fi
}

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

export EDITOR=lvim
export FZF_DEFAULT_COMMAND='fd'
export FZF_CTRL_T_COMMAND='fd'
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {} 2>/dev/null || tree -C {}'"
export PATH=$HOME/dev/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.strat:$PATH
export PATH=$HOME/ukg/local/bin:$PATH
export PATH=$HOME/repos/bdes/handy-scripts:$PATH

export NVM_DIR=$HOME/.nvm
export CONFIG_DIR=$HOME/dev/config
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"	

source_if_exists "$CONFIG_DIR/.aliases"
source_if_exists "$CONFIG_DIR/.functions.bash"
source_if_exists "$HOME/.fzf.zsh"
# source_if_exists "/opt/homebrew/opt/nvm/nvm.sh"
# source_if_exists "$HOME/.jabba/jabba.sh"
source_if_exists "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# source_if_exists "$HOME/.docker/init-zsh.sh" 
# source_if_exists "$HOME/.iterm2_shell_integration.zsh" 

load_nvm() {
  source_if_exists "/opt/homebrew/opt/nvm/nvm.sh"
}

## --------
## bindkeys
## --------
bindkey -e
bindkey -s '^f' 'find_files\n'
bindkey -s '^n' 'vifm\n'
# bindkey -s '^t' 'todo\n'
bindkey -s '^s' 'search '

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line
bindkey '^X^e' edit-command-line

eval "$(zoxide init zsh)"
eval "$(starship init zsh)" 

# Add ssh
ssh-add --apple-use-keychain

## ZPLUG
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh


zplug "reegnz/jq-zsh-plugin"
zplug "plugins/git", from:oh-my-zsh

# export NVM_LAZY_LOAD=true
# zplug "lukechilds/zsh-nvm"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
