#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  embed-avatar.sh — turn your anime character PNG into a Base64 <image> tag
#  that you can paste into banner.svg / banner-light.svg / lanyard.svg.
#
#  Usage:
#     ./embed-avatar.sh path/to/your-avatar.png
#
#  What it does:
#   1. (optional) removes a WHITE background using ImageMagick, producing a
#      transparent PNG  ->  avatar-cut.png
#   2. Base64-encodes it and writes ready-to-paste snippets to:
#         snippet-banner.txt   (x=522 y=152 w=236 h=236 — center hologram)
#         snippet-lanyard.txt  (x=164 y=254 w=92  h=92  — ID card)
#
#  Requirements: bash + base64 (built-in). ImageMagick optional (for bg removal).
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

SRC="${1:-}"
if [[ -z "$SRC" || ! -f "$SRC" ]]; then
  echo "❌ Pass a path to your avatar PNG:  ./embed-avatar.sh my-avatar.png"
  exit 1
fi

CUT="avatar-cut.png"

# 1) Background removal (white -> transparent). Skips gracefully if no ImageMagick.
if command -v magick >/dev/null 2>&1; then
  echo "🎨 Removing white background with ImageMagick…"
  magick "$SRC" -fuzz 12% -transparent white "$CUT"
elif command -v convert >/dev/null 2>&1; then
  echo "🎨 Removing white background with ImageMagick (convert)…"
  convert "$SRC" -fuzz 12% -transparent white "$CUT"
else
  echo "⚠️  ImageMagick not found — skipping background removal."
  echo "    For a PERFECT cut-out, use https://remove.bg then re-run on the result."
  CUT="$SRC"
fi

# 2) Base64 encode + build snippets
B64="$(base64 < "$CUT" | tr -d '\n')"

printf '<image href="data:image/png;base64,%s" x="522" y="152" width="236" height="236" preserveAspectRatio="xMidYMid slice"/>\n' "$B64" > snippet-banner.txt
printf '<image href="data:image/png;base64,%s" x="164" y="254" width="92"  height="92"  preserveAspectRatio="xMidYMid slice"/>\n' "$B64" > snippet-lanyard.txt

echo ""
echo "✅ Done."
echo "   • snippet-banner.txt  → paste inside the avatar <g clip-path=\"url(#avatarClip)\"> group"
echo "                            in banner.svg AND banner-light.svg (replace the placeholder shapes)."
echo "   • snippet-lanyard.txt → paste inside the <g clip-path=\"url(#lanAvatar)\"> group in lanyard.svg."
echo ""
echo "   Tip: look for the comment  <!-- Replace ... with: <image href=... -->  in each file."
