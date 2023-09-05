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
export PATH="/opt/homebrew/opt/influxdb@1/bin:$PATH"

# ~/.tmux/plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

export NVM_DIR=$HOME/.nvm
export CONFIG_DIR=$HOME/dev/config
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"	

source_if_exists "$CONFIG_DIR/.aliases"
source_if_exists "$CONFIG_DIR/.functions.bash"
source_if_exists "$HOME/.fzf.zsh"
source_if_exists "$HOME/.docker_aliases"

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
# export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
# source $ZPLUG_HOME/init.zsh


# zplug "plugins/git", from:oh-my-zsh
# zplug "djui/alias-tips"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
zi load "reegnz/jq-zsh-plugin"
zinit ice from'gh-r' as'program'
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
