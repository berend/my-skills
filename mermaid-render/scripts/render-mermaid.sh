#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") INPUT.mmd OUTPUT.{png,svg} [mmdr options...]" >&2
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

case "${output##*.}" in
  png | svg) output_format=${output##*.} ;;
  *)
    echo "Unsupported output format: $output (expected .png or .svg)" >&2
    exit 65
    ;;
esac

if ! command -v mmdr >/dev/null 2>&1; then
  cat >&2 <<'EOF'
The mmdr Mermaid renderer was not found. Install it with:
  cargo install mermaid-rs-renderer
or make mmdr available on PATH.
EOF
  exit 69
fi

mmdr --input "$input" --output "$output" --outputFormat "$output_format" "$@"

[[ -f "$output" ]] || {
  echo "mmdr finished without creating: $output" >&2
  exit 70
}
