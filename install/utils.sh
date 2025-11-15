#!/bin/bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log()    { echo -e "$$ {BLUE}[ $$(date +'%H:%M:%S')]${NC} $1"; }
success(){ echo -e "${GREEN}SUCCESS: $1${NC}"; }
warn()   { echo -e "${YELLOW}WARN: $1${NC}"; }
error()  { echo -e "${RED}ERROR: $1${NC}"; exit 1; }

CONFIG_DIR="$HOME/.config/wezterm"
FONT_DIR="$HOME/.local/share/fonts"
REPO_URL="https://github.com/vannghiem848/wezterm-xinxo.git"
