#!/bin/sh

while true; do
  echo "Contents of user files:"
  for file in /srv/ckpool/logs/users/*; do
    [ -f "$file" ] || continue
    echo "Contents of $file:"
    cat "$file"
  done
  sleep 60
done