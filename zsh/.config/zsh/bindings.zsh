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

