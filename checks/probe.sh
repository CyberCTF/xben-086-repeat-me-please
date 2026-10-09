#!/bin/sh
# /generate repeats the given sentence the given number of times.
curl -fsS --max-time 10 -d 'sentence=probe42&number=2' http://app:4567/generate | grep -c 'probe42' | grep -qv '^0$'
