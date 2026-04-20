#!/usr/bin/env bash

source "$APPROVALS_BASH"
source "$LIB_PATH/html_to_markdown.sh"

describe "html_to_markdown"
  
  # Test 1: Simple HTML
  fixture=$(cat "$FIXTURES_PATH/simple.html")
  approve "echo \"\$fixture\" | html_to_markdown" "html_to_markdown_simple"
  unset fixture
  
  # Test 2: Formatted HTML
  fixture=$(cat "$FIXTURES_PATH/formatted.html")
  approve "echo \"\$fixture\" | html_to_markdown" "html_to_markdown_formatted"
  unset fixture
  
  # Test 3: Lists HTML
  fixture=$(cat "$FIXTURES_PATH/lists.html")
  approve "echo \"\$fixture\" | html_to_markdown" "html_to_markdown_lists"
  unset fixture
  
  # Test 4: Empty HTML
  fixture=$(cat "$FIXTURES_PATH/empty.html")
  approve "echo \"\$fixture\" | html_to_markdown" "html_to_markdown_empty"
  unset fixture
  
  # Test 5: Apple Notes format
  fixture=$(cat "$FIXTURES_PATH/apple_notes_sample.html")
  approve "echo \"\$fixture\" | html_to_markdown" "html_to_markdown_apple_notes_sample"
  unset fixture
  
  # Test 6: Apple Notes heading styles (H1=24px, H2=18px, H3=bold)
  fixture=$(cat "$FIXTURES_PATH/apple_notes_headings.html")
  approve "echo \"\$fixture\" | html_to_markdown" "html_to_markdown_apple_notes_headings"
  unset fixture
