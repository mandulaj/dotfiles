#!/bin/sh
# ~/.local/bin/sway-lock-script.sh

DO_TIMEOUT=${1:-true}

# GUARD CLAUSE:
# If swaylock is already running, exit immediately.
# This prevents the system-wide swayidle from spawning multiple locks.
if pgrep -x "swaylock" > /dev/null; then
    exit 0
fi



# 1. Start a temporary swayidle process in the background.
#    - Turn off screen after 5 seconds of inactivity
#    - Turn it back on when activity resumes
if [ "$DO_TIMEOUT" = true ]; then
swayidle -w \
   timeout 5 'swaymsg "output * dpms off"' \
   resume 'swaymsg "output * dpms on"' &
fi

# Capture the Process ID (PID) of the swayidle command we just ran
IDLE_PID=$!

trap "kill $IDLE_PID" EXIT

# 2. Lock the screen immediately
#    -f ensures it locks before processing further
swaylock --clock --screenshot --effect-vignette 0.5:1 --effect-pixelate 30x30
