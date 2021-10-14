#!/usr/bin/env bash

if [ -d "Public" ];
then
    rm -r "Public/"
fi

if [ -d "Source/articles" ] && [ "$(ls Source/articles/*.html | wc -l)" -ge "1" ];
then
    for file in Source/articles/*.html; do
        rm "$file"
    done
fi
