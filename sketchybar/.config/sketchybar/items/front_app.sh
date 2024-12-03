#!/bin/bash

sketchybar --add item front_app left \
           --set front_app background.color=$ACCENT_COLOR \
                           icon.color=$BLACK \
                           icon.font="sketchybar-app-font:Regular:16.0" \
                           label.color=$BLACK \
                           display=active \
                           click_script="open -a 'Mission Control'" \
                           script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched
