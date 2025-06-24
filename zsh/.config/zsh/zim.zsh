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

# -------------------------------
# Zim Module Configuration
# -------------------------------
zstyle ':zim:zmodule' use 'degit'
zstyle ':zim:git' aliases-prefix 'G'
zstyle ':zim:input' double-dot-expand yes

# Use menu selection for completion
zstyle ':completion:*' menu select
zmodload zsh/complist

# Initialize zsh-defer.
source ${ZIM_HOME}/modules/zsh-defer/zsh-defer.plugin.zsh

# Defer evals and cache the results on first run via the evalcache plugin (clear the cache w/ `_evalcache_clear`).
zsh-defer _evalcache zoxide init zsh
zsh-defer _evalcache direnv hook zsh
zsh-defer _evalcache fnm env --use-on-cd --shell zsh
zsh-defer _evalcache ng completion script
zsh-defer _evalcache atuin init zsh

