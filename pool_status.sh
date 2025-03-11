#!/bin/sh

while true; do 
  sleep 2
  echo 'Contents of pool.status:' 
  cat /srv/ckpool/logs/pool/pool.status 
  echo 'Users in the user directory:' 
  ls /srv/ckpool/logs/users 
  sleep 30
done