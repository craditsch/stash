read_note() {
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
        return ""
      end if
      
      return body of theNote
    on error
      return ""
    end try
  end tell
end run
APPLESCRIPT
)
	
	if [ -z "$result" ]; then
		return 1
	else
		echo "$result"
		return 0
	fi
}
