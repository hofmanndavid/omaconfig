#!/usr/bin/env bash
set -euo pipefail

# system-cleanup.sh
# Run periodically to clean up orphaned packages, old cache, and stale logs.

echo "=== System Cleanup ==="

# --- Remove orphaned packages (dependencies no longer needed) ---
echo ""
echo "--- Checking for orphaned packages ---"
ORPHANS=$(pacman -Qdtq 2>/dev/null || true)
if [ -n "$ORPHANS" ]; then
  echo "Found orphans:"
  echo "$ORPHANS"
  sudo pacman -Rns --noconfirm $ORPHANS
  echo "Orphans removed."
else
  echo "No orphaned packages found."
fi

# --- Clear old package cache (keep only current version) ---
echo ""
echo "--- Clearing old package cache ---"
sudo pacman -Sc --noconfirm
echo "Package cache cleaned."

# --- Trim systemd journal logs older than 2 weeks ---
echo ""
echo "--- Trimming journal logs ---"
echo "Current journal size: $(journalctl --disk-usage 2>&1 | grep -oP '[\d.]+\s*\w+')"
sudo journalctl --vacuum-time=2weeks
echo "Journal trimmed."

# --- Check for .pacnew files that need manual merging ---
echo ""
echo "--- Checking for .pacnew files ---"
PACNEW=$(sudo find /etc -name "*.pacnew" 2>/dev/null || true)
if [ -n "$PACNEW" ]; then
  echo "Found .pacnew files that need manual review:"
  echo "$PACNEW"
  echo ""
  echo "For each file, compare with: diff <original> <original>.pacnew"
  echo "Then merge changes and delete the .pacnew file."
else
  echo "No .pacnew files found."
fi

echo ""
echo "=== Cleanup Done ==="
