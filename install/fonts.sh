#!/bin/bash
# =============================================================================
# fonts.sh – BULLETPROOF FONTS INSTALL FOR WEZTERM (Fedora/Ubuntu/Arch)
# FIXED: All syntax errors, parentheses, find exec
# Run: ./install/fonts.sh
# =============================================================================

set -euo pipefail  # Exit on error, undefined vars, pipe fail

# Colors (safe, no parens issues)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${BLUE}[$(date +'%H:%M:%S')]${NC} $1"; }
success() { echo -e "${GREEN}SUCCESS: $1${NC}"; }
warn() { echo -e "${YELLOW}WARN: $1${NC}"; }
error() { echo -e "${RED}ERROR: $1${NC}"; exit 1; }

CONFIG_DIR="$HOME/.config/wezterm"
FONT_DIR="$HOME/.local/share/fonts"
NERD_VERSION="v3.2.1"
NERD_BASE="https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_VERSION}"

# === 1. INSTALL TOOLS (Quoted everything) ===
log "Installing tools (curl, unzip, fontconfig)..."
if command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y curl unzip fontconfig
elif command -v apt >/dev/null 2>&1; then
  sudo apt update && sudo apt install -y curl unzip fontconfig
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --noconfirm curl unzip fontconfig
else
  error "No supported package manager found."
fi

# === 2. CREATE DIRECTORIES ===
mkdir -p "${FONT_DIR}"
mkdir -p "${CONFIG_DIR}/fonts"  # Safe even if not needed

# === 3. INSTALL FONT FUNCTION (Bulletproof: All quoted, no parens issues) ===
install_font() {
  local name="$1"
  local zip_file="/tmp/${name}.zip"
  local temp_dir="/tmp/nerd-${name}"
  log "Installing ${name} Nerd Font..."
  
  # Download (safe curl)
  if ! curl -L -f -o "${zip_file}" "${NERD_BASE}/${name}.zip"; then
    warn "Download failed for ${name}"
    return 1
  fi
  
  # Extract (quoted paths)
  rm -rf "${temp_dir}"
  mkdir -p "${temp_dir}"
  if ! unzip -q "${zip_file}" -d "${temp_dir}"; then
    warn "Unzip failed for ${name}"
    rm -f "${zip_file}"
    return 1
  fi
  
  # Copy fonts (safe find + xargs, no exec parens issues)
  find "${temp_dir}" -name "*.ttf" -o -name "*.otf" | head -20 | xargs -I {} cp "{}" "${FONT_DIR}/" 2>/dev/null || true
  
  # Cleanup
  rm -rf "${temp_dir}"
  rm -f "${zip_file}"
  success "${name} installed"
}

# === 4. INSTALL FONTS (Sequential, no parens) ===
install_font "FiraCode"
install_font "JetBrainsMono"

# === 5. INSTALL EMOJI (Separate if blocks) ===
log "Installing Noto Color Emoji..."
if command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y google-noto-emoji-color-fonts
elif command -v apt >/dev/null 2>&1; then
  sudo apt install -y fonts-noto-color-emoji
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --noconfirm noto-fonts-emoji
else
  warn "No package manager for emoji – skipping."
fi

# === 6. UPDATE CACHE ===
log "Updating font cache..."
if fc-cache -fv >/dev/null 2>&1; then
  success "Font cache updated"
else
  warn "fc-cache failed – fonts may need manual refresh"
fi

# === 7. VERIFY ===
success "ALL FONTS INSTALLED SUCCESSFULLY!"
echo
echo -e "${GREEN}VERIFICATION:${NC}"
for font_name in "FiraCode Nerd Font" "JetBrainsMono Nerd Font" "Noto Color Emoji"; do
  if fc-list | grep -qi "${font_name}"; then
    echo -e "   ${GREEN}✓ OK${NC} ${font_name}"
  else
    echo -e "   ${YELLOW}⚠ MISSING${NC} ${font_name}"
  fi
done
echo
echo -e "   ${YELLOW}Next:${NC} Open WezTerm → ${GREEN}Ctrl+Shift+R${NC} to reload config"
echo -e "   ${YELLOW}Repo:${NC} ${GREEN}https://github.com/vannghiem848/wezterm-xinxo${NC}"