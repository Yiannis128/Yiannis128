#!/usr/bin/env bash

SRC="public/"
DEST="/var/www/yiannis-charalambous"
CHOWN="http:http"
SERVER=yiannis@yiannis-charalambous.com

echo "Make sure that $DEST exists"

rsync -uvrP --delete-after -e \
"ssh -i ~/.ssh/yiannis-charalambous.com" \
$SRC $SERVER:$DEST

echo "Complete"
