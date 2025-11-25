#!/bin/sh
# ~/.local/bin/sway-lock-script.sh

# 1. Start a temporary swayidle process in the background.
#    - Turn off screen after 5 seconds of inactivity
#    - Turn it back on when activity resumes
swayidle -w \
   timeout 5 'swaymsg "output * dpms off"' \
   resume 'swaymsg "output * dpms on"' &

# Capture the Process ID (PID) of the swayidle command we just ran
IDLE_PID=$!

# 2. Lock the screen immediately
#    -f ensures it locks before processing further
swaylock --clock --screenshot --effect-pixelate 30x30 --effect-vignette 0.5:1
# 3. Kill the temporary swayidle process
#    This runs only *after* swaylock finishes (when you unlock the computer)
kill $IDLE_PID
