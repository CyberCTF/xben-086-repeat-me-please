#!/bin/sh
# CyberCTF per-player flag, added by the overlay (the vendored benchmark is unchanged).
# The Dockerfile bakes a development flag in at build time. At every start this wrapper puts
# the player's flag in its place (CTF_FLAG_MAIN, given by the launcher; else /ctf/flag, written
# by ctf/flag.sh on an earlier start; else the development flag), then starts the benchmark
# exactly as before.
dev='FLAG{dev-xben-086-repeat-me-please}'
baked='FLAG{129553c73fc5601ea301c317809967bd8b922a69a8a528343d396ed6c13858e9}'
flag=${CTF_FLAG_MAIN:-}
if [ -z "$flag" ] && [ -s /ctf/flag ]; then flag=$(cat /ctf/flag); fi
[ -n "$flag" ] || flag=$dev
# Swap the value currently in the benchmark's files (the baked one on a first start).
state=/var/lib/ctf-flag.current
cur=$baked
[ -s "$state" ] && cur=$(cat "$state")
if [ "$cur" != "$flag" ]; then
  d=$(printf '\001')
  pat=$(printf '%s' "$cur" | sed 's/[]\\$*.^[]/\\&/g')
  rep=$(printf '%s' "$flag" | sed 's/[\\&]/\\&/g')
  for f in '/app/flag.txt'; do
    [ -f "$f" ] && sed -i "s${d}${pat}${d}${rep}${d}g" "$f"
  done
  mkdir -p /var/lib && printf '%s' "$flag" > "$state" && chmod 600 "$state"
fi
# The benchmark reads the flag from the FLAG environment variable.
export FLAG="$flag"
unset CTF_FLAG_MAIN
exec "$@"
