#!/usr/bin/env bash

REPO_DIR=$HOME/dev/repos
BUILD_DIR=$REPO_DIR/gei/forge-build-plans-ist
#
### ARCHIVE EXTRACTION
# usage: ex <file>
ex () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *.deb)       ar x "$1"      ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.tar.zst)   unzstd "$1"    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

pods() {
  FZF_DEFAULT_COMMAND="kubectl get pods --all-namespaces" \
    fzf --info=inline --layout=reverse --header-lines=1 \
        --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
        --header $'╱ Enter (kubectl exec) ╱ CTRL-O (open log in editor) ╱ CTRL-R (reload) ╱\n\n' \
        --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden|)' \
        --bind 'enter:execute:kubectl exec -it --namespace {1} {2} -- bash > /dev/tty' \
        --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --all-containers --namespace {1} {2}) > /dev/tty' \
        --bind 'ctrl-r:reload:$FZF_DEFAULT_COMMAND' \
        --preview-window up:follow \
        --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@"
}

# A better way to do git clone
clone() {
   url=$1;

   if [[ "$url" == "-" ]]; then
       read -r std_in;
       url=$std_in
   fi

   if [[ "$url" == "" ]]; then
       return 1;
   fi

   reponame=$(echo "$url" | awk -F/ '{print $(NF-1)"/"$NF}' | sed -e 's/.git$//' | sed -e 's/.*://'); 
   destination=$REPO_DIR/$reponame
   if [ ! -d "$destination" ]; then
      if [[ "$url" =~ 'github' ]]; then
          gh repo clone "$url" "$destination"
      else
          git clone "$url" "$destination"
      fi
   fi
   cd "$destination" || return
}

list_projects_git() {
  list_build_git; 
  list_repo_git;
}

list_build_git() {
   rg ssh://\.\* "$BUILD_DIR" -o --no-filename | tr -d "'" 
}

list_repo_git() {
   rg 'url.*' -o --no-filename -g 'config' --max-count 1 --max-depth 4 --no-ignore --hidden "$REPO_DIR" | cut -f3 -d" " | sed 's/^git/ssh:\/\/git/' 
}

choose_build() {
    INITIAL_QUERY="$1"
    UPDATE_BUILD_CMD="git -C '$BUILD_DIR' pull > /dev/null"
    fzf --bind "ctrl-r:execute:$UPDATE_BUILD_CMD || true" \
        --query "$INITIAL_QUERY" \
        --height=50%
}

pclone() {
    list_projects_git | sort -u | choose_build "$@" | clone -
}

## String helper ## 
ltrim() {
    sed -E 's/^[[:space:]]+//'
}

rtrim() {
    sed -E 's/[[:space:]]+$//'
}

trim() {
    ltrim | rtrim
}

treee() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# mkdir and cd
mkcd() {
	mkdir -p -- "$1" && cd -P -- "$1" || exit
}

# fzf browse files
find_files() {
	IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0 --prompt 'files:'))
	[[ -n "$files" ]] && ${EDITOR} "${files[@]}"
}

# fzf browse directories and cd into them
find_dir() {
	local dir
	dir=$(fd -IH -t d 2> /dev/null | fzf --prompt 'folders:' +m --preview-window='right:50%:nohidden:wrap' --preview='exa --tree --level=2 {}') && 
        cd "$dir" || return
}

# list env variables
list_env() {
	local var
	var=$(printenv | cut -d= -f1 | fzf --prompt 'env:' --preview='printenv {}') \
		&& echo "$var=$(printenv "$var")" \
		&& unset var
}

# search regex in current directory
search() {
	[[ $# -eq 0 ]] && { echo "provide regex argument"; return; }
	local matching_files
	case $1 in
		-h)
			shift
			regex=$1
			matching_files=$(rg -l --hidden "${regex}" | fzf --exit-0 --preview="rg --color=always -n '${regex}' {} ")
			;;
		*)
			regex=$1
			matching_files=$(rg -l -- "${regex}" | fzf --exit-0 --preview="rg --color=always -n -- '${regex}' {} ")
			;;
	esac
	[[ -n "$matching_files" ]] && ${EDITOR} "${matching_files}" -c/"${regex}"
}


# paginate help
help() { "$@" --help | bat -l man -p ; }


# preview files
preview_files() {
	local selection
	if [[ -z "$1" ]]; then
		selection="$(fd -H -t f -E '.git/' | fzf)" && preview_files "$selection"
		return 0
	fi

	case $1 in
		-e)
			shift
			selection="$(fd -H -t f -E '.git/' -e "$1" | fzf --exit-0)" && preview_files "$selection"
			shift
			;;
		*.md)
			glow -p "$1";;
		*.json)
			jq '.' -C "$1" | less;;
		*.pdf)
			open "$1";;
		*)
			bat --theme='Solarized (dark)' --style='header,grid' "$1";;
	esac
}


# json_diff
json_diff() {
	[[ $# != 2 ]] && { echo "expected two arguments"; return; }
	[[ ( $1 != *.json ) || ( $2 != *.json ) ]] && { echo "arguments must be both json files"; return;}
	[[ ! -f $1 ]] && { echo "cannot find $1"; return;}
	[[ ! -f $2 ]] && { echo "cannot find $2"; return;}

	delta <(jq -S . "$1") <(jq -S . "$2")
}

function cheatsh {
    curl "https://cheat.sh/${1}"
}

# Taken from Symfony installer
function output {
    style_start=""
    style_end=""
    if [ "${2:-}" != "" ]; then
        case $2 in
            "success")
                style_start="\033[0;32m"
                style_end="\033[0m"
                ;;
            "error")
                style_start="\033[31;31m"
                style_end="\033[0m"
                ;;
            "info"|"warning")
                style_start="\033[33m"
                style_end="\033[39m"
                ;;
            "heading")
                style_start="\033[1;33m"
                style_end="\033[22;39m"
                ;;
        esac
    fi

    builtin echo -e "${style_start}${1}${style_end}"
}

function output_success {
    output "${1}" 'success'
}
function output_heading {
    output "${1}" 'heading'
}
function output_info {
    output "${1}" 'info'
}
function output_warning {
    output "${1}" 'warning'
}
function output_error {
    output "${1}" 'error'
}


# Tmux section
function create_config_tmux_session() {
  SESSION_NAME="config"

  tmux list-sessions | grep $SESSION_NAME || (
    tmux new-session -d -s $SESSION_NAME -c ~/dev/dotfiles -n 'dotfiles'
    tmux send-keys -t "$SESSION_NAME:1" 'gst' Enter
  )

  WINDOW_NAME="notes"
  tmux list-windows | grep "$WINDOW_NAME" || (
    tmux new-window -n "$WINDOW_NAME"
    tmux send-keys -t "$SESSION_NAME" 'cd ~/dev/docs/notes' Enter
    tmux send-keys -t "$SESSION_NAME" "$EDITOR " Enter
  )

  tmux select-window -t $SESSION_NAME:1
}

# tmux session creation/loading with FZF
function tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"

  if [ "$1" ]; then
    tmux "$change" -t "$1" 2>/dev/null || (tmux new-session -d -s "$1" && tmux "$change" -t "$1"); return
  fi

  session=$( \
    tmux list-sessions -F "#{session_name}" 2>/dev/null \
    | fzf --select-1 --exit-0 \
  )

  if [[ -n "$session" ]]; then 
    tmux "$change" -t "$session" 
  else
    create_config_tmux_session
  fi
}

function notify() {
    TITLE="Script"
    MSG=${1:-"Script"}
    osascript -e "display notification '$MSG' with title '$TITLE'"
}


