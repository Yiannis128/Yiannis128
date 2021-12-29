#!/usr/bin/env sh

echo "article index compiler: compiling article index"
./compile-article-index.sh

echo
echo "article compiler: compiling articles"
./compile-articles.sh -q

echo
echo "static builder: running packager"
./package.py Source Public


