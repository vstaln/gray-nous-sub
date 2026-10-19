#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/nous-sub.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/nous-sub" ;;
    *) rel="x86_64-apple-darwin/nous-sub" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/nous-sub" ;;
    *) rel="x86_64-unknown-linux-musl/nous-sub" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/nous-sub.exe" "$here/target/release/nous-sub" "$here/target/debug/nous-sub.exe" "$here/target/debug/nous-sub"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "nous-sub binary not found in $here" >&2
exit 1
