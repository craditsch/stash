# Helper: Convert Apple Notes heading patterns to proper HTML headings
# Apple Notes uses styled divs for headings:
#   H1 (Title):      <div><b><span style="font-size: 24px">...</span></b></div>
#   H2 (Heading):    <div><b><span style="font-size: 18px">...</span></b></div>
#   H3 (Subheading): <div><b>...</b></div>  (same as bold text, cannot distinguish)
_convert_apple_headings() {
	sed -e 's/<div><b><span style="font-size: 24px">\(.*\)<\/span><\/b><\/div>/<h1>\1<\/h1>/' \
	    -e 's/<div><b><span style="font-size: 18px">\(.*\)<\/span><\/b><\/div>/<h2>\1<\/h2>/'
}

# Helper: Remove nbsp list separators
_remove_nbsp() {
	sed 's/^&nbsp;$//'
}

# Helper: Remove standalone hard breaks from Apple Notes blank lines
_remove_hard_breaks() {
	sed 's/^\\$//'
}

# Helper: Trim trailing whitespace
_trim_trailing_whitespace() {
	sed 's/[[:space:]]*$//'
}

html_to_markdown() {
	cat | _convert_apple_headings | pandoc -f html -t gfm-raw_html --wrap=none | _remove_nbsp | _remove_hard_breaks | _trim_trailing_whitespace | cat -s || {
		echo "Error: Failed to convert HTML to markdown" >&2
		return 1
	}
}
