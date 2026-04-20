delete_note() {
	local note_id="$1"
	
	result=$(osascript 2>&1 - "$note_id" <<'APPLESCRIPT'
on run argv
  set noteId to item 1 of argv
  tell application "Notes"
    try
      set deletedNotesFolder to folder "Recently Deleted"
      set theNote to first note whose id is noteId
      set theFolder to container of theNote
      
      if theFolder is equal to deletedNotesFolder then
        error "Note already in Recently Deleted"
      end if
      
      delete theNote
      return noteId
    on error errMsg
      error errMsg
    end try
  end tell
end run
APPLESCRIPT
)
	
	# Check if result matches the note_id we tried to delete
	if [ "$result" = "$note_id" ]; then
		echo "$result"
		return 0
	else
		echo "Error: Failed to delete note $note_id: $result" >&2
		return 1
	fi
}
