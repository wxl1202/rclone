#!/bin/sh

set -e

sh -c "git config --global --add safe.directory /github/workspace"
sh -c "git-restore-mtime --work-tree $GITHUB_WORKSPACE"

if [[ -n "$RCLONE_CONFIG" ]]
then
  mkdir -p ~/.config/rclone
  echo "$RCLONE_CONFIG" > ~/.config/rclone/rclone.conf
fi

sh -c "rclone $*"
