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

# Use degit instead of git as the default tool to install and update modules.
zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'G'

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

# Disable automatic widget re-binding on each precmd
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Set what highlighters will be used.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Colorize completions using default `ls` colors.
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Configure zsh-vim-mode
KEYTIMEOUT=1
VIM_MODE_NO_DEFAULT_BINDINGS=true
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_VISUAL="block"

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# Initialize zsh-defer.
source ${ZIM_HOME}/modules/zsh-defer/zsh-defer.plugin.zsh

# Defer evals and cache the results on first run via the evalcache plugin (clear the cache w/ `_evalcache_clear`).
zsh-defer _evalcache zoxide init zsh
zsh-defer _evalcache direnv hook zsh
zsh-defer _evalcache fnm env --use-on-cd --shell zsh
zsh-defer _evalcache ng completion script
zsh-defer _evalcache atuin init zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

_source_if_exists "$CONFIG_DIR/aliases.zsh"
_source_if_exists "$CONFIG_DIR/docker_aliases.zsh"
_source_if_exists "$CONFIG_DIR/functions.zsh"
_source_if_exists "$CONFIG_DIR/os.zsh"
_source_if_exists "$HOME/.fzf.zsh"
_source_if_exists "$HOME/work/setup.zsh"

## --------
## bindkeys
## --------

# zsh-history-substring-search
zmodload -F zsh/terminfo +p:terminfo
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# Restore standard keybinds in vi-mode
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line
bindkey -M vicmd '_' vi-first-non-blank

bindkey -M viins '^f' tmux_sessionizer

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

bindkey '^Y' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
