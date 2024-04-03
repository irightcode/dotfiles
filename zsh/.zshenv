# Editor
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER='nvim +Man!'

# workspace
export DOTFILES="$HOME/dotfiles"
export CODE_DIR="$HOME/repos"

# zsh
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

export CONFIG_DIR=$HOME/.config/zsh
export NVM_DIR=$HOME/.nvm
export XDG_CONFIG_HOME=$HOME/.config 

# starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--reverse --border=rounded --prompt ' λ '"

# Path
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/work/bin:$PATH
export PATH=$HOME/dev/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
