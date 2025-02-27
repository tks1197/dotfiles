#!/bin/bash
# Create a new note for today's journal entry
note_path=$(zk new --no-input "$ZK_NOTEBOOK_DIR/journal/daily" --print-path)

# Append the current time to the newly created note
echo "- $(date +'%H:%M:%S')" >>"$note_path"

# Optionally, create a new note again if needed (this line seems redundant based on your original command)
zk edit "$note_path"
