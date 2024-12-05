#!/usr/bin/env bash
source "$CONFIG_DIR/colors.sh"

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item space.$sid left \
             --set space.$sid \
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

sketchybar   --add item       separator left                          \
             --set separator  icon=                                  \
                              background.padding_left=15              \
                              background.padding_right=15             \
                              label.drawing=off                       \
                              icon.color=$WHITE
                              # associated_display=active               \

# sketchybar --add bracket spaces '/space\..*/'               \
#            --set         spaces background.color=0xffff6a00 \
#                                 background.corner_radius=4  \
#                                 background.height=30
