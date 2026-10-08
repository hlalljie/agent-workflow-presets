#!/usr/bin/env bash
# Maintains .cursor/blueprints.md in the current directory (the project root).
# Requires bash and git. Line format: "- <part> | <source> | <sha> | <date>".
set -euo pipefail

LOCK=".cursor/blueprints.md"

usage() {
  cat >&2 <<'EOF'
usage:
  lock.sh set <part> <source> <sha>
  lock.sh get <part>
  lock.sh list
  lock.sh changed <catalog-dir> <part>
EOF
  exit 64
}

# Prints field N (2=source, 3=sha, 4=date) of the line for <part>; exits 1 if absent.
lookup() {
  [ -f "$LOCK" ] || return 1
  awk -F' \\| ' -v key="- $1" -v n="$2" '$1 == key { print $n; f = 1 } END { exit !f }' "$LOCK"
}

cmd=${1:-}
[ -n "$cmd" ] || usage
shift

case "$cmd" in
  set)
    [ $# -eq 3 ] || usage
    mkdir -p .cursor
    if [ ! -f "$LOCK" ]; then
      printf '%s\n' '# Blueprints applied' '' 'Written by the blueprint lock script. Do not edit by hand.' '' > "$LOCK"
    fi
    line="- $1 | $2 | $3 | $(date +%F)"
    tmp=$(mktemp)
    awk -F' \\| ' -v key="- $1" -v line="$line" '
      $1 == key { if (!done) print line; done = 1; next }
      { print }
      END { if (!done) print line }
    ' "$LOCK" > "$tmp"
    mv "$tmp" "$LOCK"
    ;;
  get)
    [ $# -eq 1 ] || usage
    src=$(lookup "$1" 2) || exit 1
    sha=$(lookup "$1" 3)
    echo "$src $sha"
    ;;
  list)
    [ -f "$LOCK" ] && grep '^- ' "$LOCK" || true
    ;;
  changed)
    [ $# -eq 2 ] || usage
    sha=$(lookup "$2" 3) || { echo "not in lock: $2" >&2; exit 1; }
    if ! git -C "$1" cat-file -e "$sha^{commit}" 2>/dev/null; then
      echo "commit $sha not found in $1 (git fetch there first)" >&2
      exit 2
    fi
    git -C "$1" diff --name-status "$sha" HEAD -- "parts/$2"
    ;;
  *)
    usage
    ;;
esac
