#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="https://github.com/krupali68/vida_engineering.git"
PROJECT_NAME="vida_engineering"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

fail() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Run from an existing checkout or clone beside this script.
if [[ -f "$SCRIPT_DIR/package.json" ]]; then
  PROJECT_DIR="$SCRIPT_DIR"
elif [[ -f "$SCRIPT_DIR/$PROJECT_NAME/package.json" ]]; then
  PROJECT_DIR="$SCRIPT_DIR/$PROJECT_NAME"
else
  command -v git >/dev/null 2>&1 || fail "Git not found. Install Git and rerun this script."
  PROJECT_DIR="$SCRIPT_DIR/$PROJECT_NAME"
  [[ ! -e "$PROJECT_DIR" ]] || fail "Directory '$PROJECT_DIR' exists but is not a valid project checkout."
  echo "Cloning $REPO_URL ..."
  git clone "$REPO_URL" "$PROJECT_DIR"
fi

command -v node >/dev/null 2>&1 || fail "Node.js is not installed. Install Node.js 22 LTS or newer (https://nodejs.org/) and rerun."
command -v npm >/dev/null 2>&1 || fail "npm is not installed. Install Node.js with npm and rerun."

NODE_VERSION="$(node -p 'process.versions.node')"
node -e 'const [maj,min]=process.versions.node.split(".").map(Number); process.exit((maj===20 && min>=19)||(maj===22 && min>=12)||maj>22 ? 0 : 1)' \
  || fail "Node.js $NODE_VERSION is too old for this Vite project. Use Node.js 22.12+ (or 20.19+)."

echo "Node.js: $NODE_VERSION | npm: $(npm --version)"
cd "$PROJECT_DIR"

if [[ -f package-lock.json ]]; then
  echo "Installing dependencies with npm ci ..."
  npm ci
else
  echo "Installing dependencies with npm install ..."
  npm install
fi

echo "Starting Vite. Open http://localhost:5173/ (or the URL printed below)."
if [[ "${1:-}" == "--network" ]]; then
  exec npm run dev -- --host 0.0.0.0
else
  exec npm run dev
fi
