#!/bin/bash

source "$CONFIG_DIR/colors.sh"

COLOR=$BACKGROUND_2
SELECTED="false"

if [ "$NAME" = "space.$FOCUSED_WORKSPACE" ]; then
  COLOR=$GREY
  SELECTED="true"
fi

sketchybar --set $NAME icon.highlight="$SELECTED" label.highlight="$SELECTED" 

apps=$(aerospace list-windows --workspace $1 --format %{app-name} | sort | uniq)

args=(--animate sin 10)

icon_strip=" "
if [ "${apps}" != "" ]; then
  while read -r app
  do
    icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
  done <<< "${apps}"
else
  icon_strip=" —"
fi
args+=(--set space.$1 label="$icon_strip")

sketchybar -m "${args[@]}"
