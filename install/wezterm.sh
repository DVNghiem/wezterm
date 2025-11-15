#!/bin/bash
source "$(dirname "$0")/utils.sh"

log "Installing WezTerm..."

if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install --cask wezterm
elif command -v apt >/dev/null; then
  curl -L https://github.com/wez/wezterm/releases/download/20241114-1132/wezterm-20241114-1132.Ubuntu22.04.deb -o /tmp/wezterm.deb
  sudo apt install -y /tmp/wezterm.deb
  rm /tmp/wezterm.deb
elif command -v pacman >/dev/null; then
  sudo pacman -S --noconfirm wezterm
elif command -v dnf >/dev/null; then
  sudo dnf install -y wezterm
else
  error "Unsupported OS. Install WezTerm manually: https://wezterm.org"
fi

success "WezTerm installed!"