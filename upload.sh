#!/usr/bin/env bash

SRC="Public/"
DEST="/var/www/yiannis-charalambous/"

CHOWN="www-data:www-data"

rsync -uvrP --delete-after $SRC root@yiannis-charalambous.com:$DEST

ssh root@yiannis-charalambous.com '
    cd /var/www/;
    chown -R www-data:www-data yiannis-charalambous/;
    exit;
'
