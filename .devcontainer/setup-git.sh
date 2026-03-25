#!/usr/bin/env bash
set -euo pipefail

git config --local core.hooksPath .githooks

name="$(git config --global user.name || true)"
email="$(git config --global user.email || true)"

echo "Current Git identity settings:"
echo "  user.name:  ${name:-<not set>}"
echo "  user.email: ${email:-<not set>}"

if [[ -z "$name" || -z "$email" ]]; then
  if [[ -t 0 ]]; then
    [[ -z "$name" ]] && read -rp "Enter your Git user.name: " name
    [[ -z "$email" ]] && read -rp "Enter your Git user.email: " email

    [[ -n "$name" ]] && git config --global user.name "$name"
    [[ -n "$email" ]] && git config --global user.email "$email"

    echo
    echo "Updated Git identity settings:"
    echo "  user.name:  $(git config --global user.name || echo '<not set>')"
    echo "  user.email: $(git config --global user.email || echo '<not set>')"
  else
    echo
    echo "Git user.name and/or user.email are not set."
    echo 'Run: git config --global user.name "Your Name"'
    echo 'Run: git config --global user.email "you@example.com"'
  fi
fi