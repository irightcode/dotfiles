# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

_source_if_exists () {
    if test -r "$1"; then
      source "$1"
    fi }

# -----------------
# Zim configuration
# -----------------

## --------
## History
## --------
HISTSIZE=130000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt append_history
setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
setopt CORRECT

# Invert + and - meanings so that directories can be selected from stack by number
setopt PUSHDMINUS

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

# Disable automatic widget re-binding on each precmd
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Set what highlighters will be used.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Colorize completions using default `ls` colors.
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# unset grep
export GREP_COLOR='31;01'

# Configure zsh-vim-mode
KEYTIMEOUT=10
VIM_MODE_NO_DEFAULT_BINDINGS=true
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_VISUAL="block"

# ------------------------------
# Post-init module configuration
# ------------------------------

_source_if_exists "$CONFIG_DIR/aliases.zsh"
_source_if_exists "$CONFIG_DIR/docker_aliases.zsh"
_source_if_exists "$CONFIG_DIR/functions.zsh"
_source_if_exists "$CONFIG_DIR/os.zsh"
_source_if_exists "$CONFIG_DIR/zim.zsh"
_source_if_exists "$CONFIG_DIR/bindings.zsh"
_source_if_exists "$CONFIG_DIR/fzf-git.sh"
_source_if_exists "$HOME/.fzf.zsh"
_source_if_exists "$HOME/work/setup.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# bun completions
[ -s "/Users/charles.russell/.bun/_bun" ] && source "/Users/charles.russell/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
