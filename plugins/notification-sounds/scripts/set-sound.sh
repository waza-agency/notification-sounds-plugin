#!/bin/bash
# set-sound.sh - Set the notification sound preference
# Usage: set-sound.sh <sound-name|random|disable|enable>

CONFIG_DIR="${HOME}/.claude/notification-sounds"
CONFIG_FILE="${CONFIG_DIR}/config.json"
CHOICE="${1:-random}"

mkdir -p "$CONFIG_DIR"
mkdir -p "$CONFIG_DIR/custom"

if [ "$CHOICE" = "disable" ]; then
  python3 -c "
import json, os
config = {}
if os.path.exists('$CONFIG_FILE'):
    config = json.load(open('$CONFIG_FILE'))
config['enabled'] = False
json.dump(config, open('$CONFIG_FILE', 'w'), indent=2)
"
  echo "Notifications disabled."
elif [ "$CHOICE" = "enable" ]; then
  python3 -c "
import json, os
config = {}
if os.path.exists('$CONFIG_FILE'):
    config = json.load(open('$CONFIG_FILE'))
config['enabled'] = True
json.dump(config, open('$CONFIG_FILE', 'w'), indent=2)
"
  echo "Notifications enabled."
else
  python3 -c "
import json, os
config = {}
if os.path.exists('$CONFIG_FILE'):
    config = json.load(open('$CONFIG_FILE'))
config['sound'] = '$CHOICE'
config['enabled'] = True
json.dump(config, open('$CONFIG_FILE', 'w'), indent=2)
"
  echo "Sound set to: $CHOICE"
fi
