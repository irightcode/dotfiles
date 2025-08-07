## --------
## bindkeys
## --------

# function zvm_after_lazy_keybindings() {
#   # In normal mode, press Ctrl-E to invoke this widget
#   zvm_bindkey vicmd '_' vi-first-non-blank
#
#   zvm_bindkey viins '^f' tmux_sessionizer
#   zvm_bindkey vicmd '^f' tmux_sessionizer
#   zvm_bindkey viins '^Y' autosuggest-accept
#   zvm_bindkey vicmd '^Y' autosuggest-accept
#   zvm_bindkey viins '`' end-of-line
#   zvm_bindkey vicmd '`' end-of-line
# }
# zsh-history-substring-search
zmodload -F zsh/terminfo +p:terminfo
# for key ('k') bindkey -M vicmd ${key} history-substring-search-up
# for key ('j') bindkey -M vicmd ${key} history-substring-search-down
# unset key

# Restore standard keybinds in vi-mode
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line
bindkey -M vicmd '_' vi-first-non-blank

bindkey -M vicmd "^V" edit-command-line
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
# incremental search in insert mode
bindkey "^F" history-incremental-search-forward
bindkey "^R" history-incremental-search-backward
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
# incremental search in vi command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
# navigate matches in incremental search
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M viins 'kj' vi-cmd-mode
# Completion menu movements
# Allow ctrl-p, ctrl-n for navigate history
bindkey '^P' up-history
bindkey '^N' down-history


zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

bindkey '^y' autosuggest-accept
bindkey '^ ' autosuggest-execute
