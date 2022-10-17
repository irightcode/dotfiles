#!/usr/bin/env bash


REPO_DIR=$HOME/dev/repos
BUILD_DIR=$REPO_DIR/forge-build-plans-ist

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
   reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
   destination=$REPO_DIR/$reponame
   if [ ! -d "$destination" ]; then
      git clone $url $destination;
   fi
   cd "$destination"
}

list_projects_git() {
  list_build_git; 
  list_repo_git;
}

list_build_git() {
   rg ssh://\.\* $BUILD_DIR -o --no-filename | tr -d "'" 
}

list_repo_git() {
   rg 'url.*' -o --no-filename -g 'config' --max-count 1 --max-depth 4 --no-ignore --hidden $REPO_DIR | cut -f3 -d" " | sed 's/^git/ssh:\/\/git/' 
}

pclone() {
   if [ $# -eq 0 ]; then
     clone $(list_projects_git | sort -u | fzf)
   else
     clone $1
   fi
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


