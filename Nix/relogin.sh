#!/bin/bash
if ! [ $(id -u) = 0 ]; then
  echo "Run this script as root" >&2
  exit 1
fi
TARGET=$1
case $TARGET in
  administrator)
    ;;
  user)
    ;;
  *)
  echo "Unknown target user" >&2
  exit 1
esac
FILE=/etc/lightdm/lightdm.conf
sed -i "s/autologin-user=[a-z]\{1,13\}/autologin-user=$TARGET/" $FILE
service lightdm restart
