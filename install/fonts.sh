#!/usr/bin/env bash

# Script: install_nerd_fonts.sh
# Description: Interactively select and install Nerd Fonts for macOS using GitHub releases + fzf.
# Author: zx0r
# Version: 1.1

set -euo pipefail

FZF_PROMPT="Select Nerd Fonts: "
FZF_HEIGHT="60%"
FZF_LAYOUT="reverse"

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

is_command_installed() { command -v "$1" &>/dev/null; }

print_step()    { echo -e "\n${CYAN}➜ ${1}${NC}\n"; }
print_success() { echo -e "\n${GREEN}✅ ${1}${NC}\n"; }
print_warn()    { echo -e "${YELLOW}[Warn] ${1}${NC}"; }
print_error()   { echo -e "${RED}❗️${1}${NC}"; exit 1; }

check_dependencies() {
  local dependencies=("curl" "fzf" "unzip")
  for dep in "${dependencies[@]}"; do
    if ! is_command_installed "$dep"; then
      print_warn "$dep is not installed."
      if [[ "$dep" == "fzf" ]]; then
        print_step "Installing fzf via Homebrew..."
        brew install fzf
      else
        print_error "Please install $dep first."
      fi
    fi
  done
}

# Fetch Nerd Fonts list from GitHub releases
fetch_nerd_fonts() {
  curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | grep "browser_download_url" \
    | grep ".zip" \
    | sed -E 's/.*\/([^\/]+)\.zip.*/\1/'
}

select_fonts() {
  local fonts="$1"
  echo "$fonts" | fzf --multi --prompt="$FZF_PROMPT" --height="$FZF_HEIGHT" --layout="$FZF_LAYOUT"
}

install_fonts() {
  local selected_fonts="$1"
  if [[ -z "$selected_fonts" ]]; then
    print_warn "No fonts selected. Exiting."
    exit 0
  fi

  print_step "Downloading and installing selected Nerd Fonts..."
  echo "$selected_fonts" | while read -r font; do
    url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.zip"
    tmpdir=$(mktemp -d)
    print_step "Downloading $font..."
    curl -L "$url" -o "$tmpdir/$font.zip"
    unzip -q "$tmpdir/$font.zip" -d "$tmpdir/$font"
    cp "$tmpdir/$font"/*.ttf ~/Library/Fonts/ || true
    rm -rf "$tmpdir"
    print_success "Installed $font."
  done
}

main() {
  print_step "Select the Nerd Fonts you want to install (TAB to select multiple):"
  check_dependencies

  local fonts
  fonts=$(fetch_nerd_fonts)
  if [[ -z "$fonts" ]]; then
    print_error "No Nerd Fonts found from GitHub API."
  fi

  local selected_fonts
  selected_fonts=$(select_fonts "$fonts")

  install_fonts "$selected_fonts"
}

main












