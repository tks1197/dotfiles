#!/bin/bash

result=$(zk list --quiet "$@")

if [ -z "$result" ]; then
  search_query=""
  while [[ "$1" != "" ]]; do
    case $1 in
    -m)
      shift
      search_query="$1"
      ;;
    esac
    shift
  done
  if [ -n "$search_query" ]; then
    search_url="https://www.google.com/search?q=$search_query"
    open "$search_url" 2>/dev/null || xdg-open "$search_url" 2>/dev/null
  else
    echo "search query is required"
  fi
else
  echo "$result"
fi
