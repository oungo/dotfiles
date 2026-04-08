#!/usr/bin/env bash

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
project=$(echo "$input" | jq -r '.workspace.project_dir')

branch=$(cd "$project" 2>/dev/null && git -c core.useBuiltinFSMonitor=false rev-parse --abbrev-ref HEAD 2>/dev/null)

input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cache_create=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

mcps=$(jq -r '[.mcpServers | keys[]] | join(", ")' "$HOME/.claude/settings.json" 2>/dev/null)

out="$model"

if [ -n "$branch" ]; then
  out="$out in $(basename "$project") on $branch"
else
  out="$out in $(basename "$project")"
fi

if [ "$context_size" -gt 0 ]; then
  used=$((input_tokens + cache_create + cache_read))
  used_k=$((used / 1000))
  context_k=$((context_size / 1000))
  out="$out | context: ${used_k}k/${context_k}k"
fi

if [ -n "$mcps" ]; then
  out="$out | mcp: $mcps"
fi

printf '%s' "$out"
