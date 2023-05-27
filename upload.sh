#!/usr/bin/env bash

SRC="public/"
DEST="/var/www/yiannis-charalambous"

CHOWN="http:http"

rsync -uvrP --delete-after -e \
"ssh -i ~/.ssh/yiannis-charalambous.com" \
$SRC root@yiannis-charalambous.com:$DEST

ssh root@yiannis-charalambous.com <<EOF

chown http:http -R /var/www/yiannis-charalambous

EOF

echo "Complete"
