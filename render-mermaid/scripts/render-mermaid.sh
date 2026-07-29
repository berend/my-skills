#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") INPUT.mmd OUTPUT.png [mmdc options...]" >&2
  exit 64
}

[[ $# -ge 2 ]] || usage

input=$1
output=$2
shift 2

[[ -f "$input" ]] || {
  echo "Mermaid input file not found: $input" >&2
  exit 66
}

output_dir=$(dirname "$output")
mkdir -p "$output_dir"

if command -v mmdc >/dev/null 2>&1; then
  renderer=(mmdc)
elif [[ -x "node_modules/.bin/mmdc" ]]; then
  renderer=("$PWD/node_modules/.bin/mmdc")
else
  cat >&2 <<'EOF'
Mermaid CLI was not found. Install it locally in this project with:
  npm install --save-dev @mermaid-js/mermaid-cli
or make mmdc available on PATH.
EOF
  exit 69
fi

"${renderer[@]}" --input "$input" --output "$output" "$@"

[[ -f "$output" ]] || {
  echo "Mermaid CLI finished without creating: $output" >&2
  exit 70
}
