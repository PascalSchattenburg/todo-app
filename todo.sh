#!/bin/bash
set -euxo pipefail

# --- Konfiguration ---
TODO_FILE="todos.json"
GIT_USER="auto-todo"  # optional
GIT_EMAIL="todo@local"  # optional

# --- Eingaben prüfen ---
if [ $# -lt 2 ]; then
  echo "❌ Verwendung: ./addtodo.sh <Owner> \"<Aufgabe>\""
  exit 1
fi

OWNER="$1"
TEXT="$2"

# --- JSON vorbereiten ---
NEW_ENTRY="{\"owner\": \"${OWNER}\", \"text\": \"${TEXT}\", \"done\": false}"

# --- Datei initialisieren, falls leer ---
if [ ! -f "$TODO_FILE" ]; then
  echo "[]" > "$TODO_FILE"
fi

# --- Neues Element anhängen ---
TEMP_FILE=$(mktemp)
jq ". + [ $NEW_ENTRY ]" "$TODO_FILE" > "$TEMP_FILE" && mv "$TEMP_FILE" "$TODO_FILE"

# --- Git commit + push ---
git config user.name "$GIT_USER"
git config user.email "$GIT_EMAIL"
git add "$TODO_FILE"
git commit -m "✅ Add task for $OWNER: $TEXT"
git push

echo "✅ Aufgabe hinzugefügt und gepusht!"