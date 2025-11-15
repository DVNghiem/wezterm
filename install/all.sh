#!/bin/bash
source "$(dirname "$0")/utils.sh"

log "Starting FULL WezTerm Xinxo Setup..."

"$CONFIG_DIR/install/wezterm.sh"
"$CONFIG_DIR/install/config.sh"
"$CONFIG_DIR/install/fonts.sh"

# Final touches
[[ ! -L "$HOME/.wezterm.lua" ]] && ln -sf "$CONFIG_DIR/wezterm.lua" "$HOME/.wezterm.lua"

success "FULL SETUP COMPLETE!"
echo
echo -e "${GREEN}   WORLD-CLASS WEZTERM READY"
echo -e "   Repo: https://github.com/vannghiem848/wezterm-xinxo"
echo -e "   X: @vannghiem848"
echo -e "   Run: wezterm → Ctrl+Shift+R${NC}"