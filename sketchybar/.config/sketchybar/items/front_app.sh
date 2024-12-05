#!/usr/bin/env bash

export COLOR=$WHITE

sketchybar \
	--add item front_app e \
	--set front_app script="$PLUGIN_DIR/front_app.sh" \
          click_script="open -a 'Mission Control'" \
          icon.drawing=off \
          background.height=26 \
          background.padding_left=0 \
          background.padding_right=10 \
          background.border_width="$BORDER_WIDTH" \
          background.border_color="$COLOR" \
          background.corner_radius="$CORNER_RADIUS" \
          background.color="$BAR_COLOR" \
          icon.font="sketchybar-app-font:Regular:16.0"\
          icon.padding_left=1 \
          icon.color="$COLOR" \
          icon.drawing=on \
          label.color="$COLOR" \
          label.padding_left=10 \
          label.padding_right=10 \
          associated_display=active \
          --subscribe front_app front_app_switched
