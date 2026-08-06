#!/usr/bin/env bash
# Local dev: compile styles, watch for changes, and serve the site at :1234.
set -e

PORT="${PORT:-1234}"

# Compile once so the first load has styles, then watch in the background.
sass css/styles.scss css/styles.css --no-source-map
sass --watch css/styles.scss:css/styles.css &
trap 'kill $! 2>/dev/null' EXIT

echo "Serving http://localhost:${PORT}  (Ctrl-C to stop)"
python3 -m http.server "$PORT"
