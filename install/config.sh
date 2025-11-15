# ~/.config/wezterm/install/config.sh
#!/bin/bash
source "$(dirname "$0")/utils.sh"

log "Cloning WezTerm config from GitHub..."
rm -rf "$CONFIG_DIR"
git clone "$REPO_URL" "$CONFIG_DIR"
chmod +x "$CONFIG_DIR/install/"*.sh 2>/dev/null || true
success "Config cloned! Path: $CONFIG_DIR"
