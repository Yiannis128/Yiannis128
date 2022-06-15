#!/usr/bin/env bash

SRC="public"
DEST="/home/yiannis/website/"

CHOWN="yiannis:yiannis"

rsync -uvrP --delete-after --chown=nginx:nginx $SRC yiannis@yiannis-charalambous.com:$DEST
