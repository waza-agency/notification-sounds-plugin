#!/bin/bash
# play-sound.sh - Plays notification sound when Claude Code finishes a task

CONFIG_DIR="${HOME}/.claude/notification-sounds"
CONFIG_FILE="${CONFIG_DIR}/config.json"
PLUGIN_DIR="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"

mkdir -p "$CONFIG_DIR"

# Load config
if [ -f "$CONFIG_FILE" ]; then
  SOUND=$(python3 -c "import json; c=json.load(open('$CONFIG_FILE')); print(c.get('sound','random'))" 2>/dev/null)
  ENABLED=$(python3 -c "import json; c=json.load(open('$CONFIG_FILE')); print(str(c.get('enabled',True)).lower())" 2>/dev/null)
else
  SOUND="random"
  ENABLED="true"
fi

# Exit if disabled
[ "$ENABLED" != "true" ] && exit 0

# Read hook input from stdin and skip if this is a subagent/background task
HOOK_INPUT=$(cat)
AGENT_ID=$(echo "$HOOK_INPUT" | python3 -c "import json, sys; data=json.load(sys.stdin); print(data.get('agent_id', ''))" 2>/dev/null)
[ -n "$AGENT_ID" ] && exit 0

# Build list of all available mp3s (plugin bundled + user custom)
FILES=()
for f in "$PLUGIN_DIR/samples"/*.mp3 "$CONFIG_DIR/custom"/*.mp3; do
  [ -f "$f" ] && FILES+=("$f")
done

[ ${#FILES[@]} -eq 0 ] && exit 0

# Select audio file
if [ "$SOUND" = "random" ]; then
  INDEX=$((RANDOM % ${#FILES[@]}))
  AUDIO_FILE="${FILES[$INDEX]}"
else
  AUDIO_FILE=""
  for f in "${FILES[@]}"; do
    NAME=$(basename "$f" .mp3)
    if [ "$NAME" = "$SOUND" ]; then
      AUDIO_FILE="$f"
      break
    fi
  done
  # Fallback to random if not found
  if [ -z "$AUDIO_FILE" ]; then
    INDEX=$((RANDOM % ${#FILES[@]}))
    AUDIO_FILE="${FILES[$INDEX]}"
  fi
fi

# Play sound (cross-platform)
if command -v afplay &>/dev/null; then
  afplay "$AUDIO_FILE" &
elif command -v paplay &>/dev/null; then
  paplay "$AUDIO_FILE" &
elif command -v ffplay &>/dev/null; then
  ffplay -nodisp -autoexit "$AUDIO_FILE" &>/dev/null &
fi

exit 0
