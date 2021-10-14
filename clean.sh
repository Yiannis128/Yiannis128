#!/usr/bin/env bash

if [ -d "Public" ];
then
    rm -r "Public/"
fi

# Basically delete everything inside Source/articles aside from
# the templates folder.
if [ -d "Source/articles" ] && [ "$(ls Source/articles/*.html | wc -l)" -ge "1" ];
then
    for file in Source/articles/*; do
        if [ -d $file ];
        then
            if [[ "$(basename $file)" != "Templates" ]];
            then
                echo "removing dir: $file"
                rm -r $file
            fi
        else
            echo "removing file: $file"
            rm "$file"
        fi
    done
fi
