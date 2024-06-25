#!/usr/bin/env sh

rm -r public

hugo

# Removing 

for file in $(find public/projects -maxdepth 1 -type f); do
    echo "Removing: $file"
    rm $file
done

