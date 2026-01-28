#!/usr/bin/env bash
set -euo pipefail

PLUGIN_NAME="hyprscrolling"
PLUGIN_PATH="${HOME}/.local/share/hypr/plugins/hyprscrolling.so"
RUNTIME_BUILD_PATH="${XDG_RUNTIME_DIR:-/run/user/${UID}}/hyprpm/$(id -un)/hyprscrolling/hyprscrolling.so"
PREV_LAYOUT_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hyprscrolling.prev-layout"
GLYPH="󰟀"

is_loaded() {
  hyprctl plugins list 2>/dev/null | rg -qi "\b${PLUGIN_NAME}\b"
}

get_layout() {
  hyprctl getoption general:layout 2>/dev/null | rg -o "str:.*" | sed 's/^str: //'
}

is_active() {
  [[ "$(get_layout)" == "scrolling" ]] && is_loaded
}

ensure_plugin_available() {
  if [[ -f "${PLUGIN_PATH}" ]]; then
    return 0
  fi

  if [[ -f "${RUNTIME_BUILD_PATH}" ]]; then
    mkdir -p "$(dirname "${PLUGIN_PATH}")"
    install -m 755 "${RUNTIME_BUILD_PATH}" "${PLUGIN_PATH}"
    return 0
  fi

  cat >&2 <<EOF
Missing plugin binary: ${PLUGIN_PATH}

To build it with hyprpm:
  hyprpm update
  hyprpm add https://github.com/hyprwm/hyprland-plugins

After that, run this toggle again.
EOF
  exit 1
}

print_status_json() {
  local status class tooltip loaded layout

  layout="$(get_layout)"

  if is_loaded; then
    loaded="loaded"
  else
    loaded="not loaded"
  fi

  if is_active; then
    status="enabled"
    class="on"
  else
    status="disabled"
    class="off"
  fi

  tooltip="Hyprscrolling: ${status} (${loaded}, layout: ${layout})"

  printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "${GLYPH}" "${tooltip}" "${class}"
}

toggle() {
  local prev_layout

  ensure_plugin_available

  if is_loaded; then
    # NOTE: `hyprctl plugin unload` matches by the original load path.
    # We try both the stable path and (if present) the runtime build path.
    hyprctl plugin unload "${PLUGIN_PATH}" >/dev/null 2>&1 || true

    if [[ -f "${RUNTIME_BUILD_PATH}" ]]; then
      hyprctl plugin unload "${RUNTIME_BUILD_PATH}" >/dev/null 2>&1 || true
    fi

    if [[ -f "${PREV_LAYOUT_FILE}" ]]; then
      prev_layout="$(cat "${PREV_LAYOUT_FILE}")"
    else
      prev_layout="dwindle"
    fi

    hyprctl keyword general:layout "${prev_layout}" >/dev/null
    return 0
  fi

  prev_layout="$(get_layout)"
  mkdir -p "$(dirname "${PREV_LAYOUT_FILE}")"
  printf '%s\n' "${prev_layout}" >"${PREV_LAYOUT_FILE}"

  hyprctl plugin load "${PLUGIN_PATH}" >/dev/null
  hyprctl keyword general:layout scrolling >/dev/null
}

case "${1:-}" in
  --status)
    print_status_json
    ;;
  "")
    toggle
    ;;
  *)
    echo "Usage: $(basename "$0") [--status]" >&2
    exit 2
    ;;
esac
