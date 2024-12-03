#!/bin/sh
source "$CONFIG_DIR/colors.sh"

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item space.$sid left \
             --set space.$sid \
                   background.drawing=off \
                   label.font="sketchybar-app-font:Regular:16.0" \
                   icon.padding_left=10 \
                   icon.padding_right=0 \
                   label.padding_left=0 \
                   label.padding_right=10 \
                   background.padding_left=2 \
                   background.padding_right=2 \
                   icon="$sid" \
                   click_script="aerospace workspace $sid" \
                   script="$PLUGIN_DIR/aerospace.sh $sid" \
             --subscribe space.$sid aerospace_workspace_change
done
