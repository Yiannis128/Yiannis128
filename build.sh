#!/usr/bin/env sh

echo "Deleting public directory"
rm -r public

echo "Rebuilding website"
hugo

