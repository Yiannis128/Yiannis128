#!/usr/bin/env sh

echo "Compiling articles"
./compile-articles.sh

echo "Running packager"
./package.py Source Public


