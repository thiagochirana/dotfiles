#!/usr/bin/env bash
# Regenerate themed assets and reload the UI components that consume them.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '==> %s\n' "$1"; }
warn() { printf '!! %s\n' "$1" >&2; }

log "Regenerating themed assets..."
"$ROOT/build_theme.sh"

if command -v hyprctl >/dev/null 2>&1; then
  if hyprctl reload >/dev/null 2>&1; then
    log "Hyprland reloaded."
  else
    warn "Failed to reload Hyprland."
  fi
else
  warn "hyprctl not found; skipping Hyprland reload."
fi

if pgrep -x waybar >/dev/null 2>&1; then
  if pkill -SIGUSR2 waybar >/dev/null 2>&1; then
    log "Waybar reloaded."
  else
    warn "Failed to signal Waybar."
  fi
else
  warn "Waybar is not running; skipping."
fi

if command -v makoctl >/dev/null 2>&1; then
  if makoctl reload >/dev/null 2>&1; then
    log "Mako reloaded."
  else
    warn "makoctl reload failed, attempting signal."
    pkill -SIGUSR1 mako >/dev/null 2>&1 || warn "Failed to reload Mako."
  fi
elif pgrep -x mako >/dev/null 2>&1; then
  pkill -SIGUSR1 mako >/dev/null 2>&1 || warn "Failed to reload Mako."
else
  warn "Mako is not running; skipping."
fi

if pgrep -x walker >/dev/null 2>&1; then
  log "Walker hot reloads styles; reopen if changes don't appear."
fi

log "Theme reload complete."
