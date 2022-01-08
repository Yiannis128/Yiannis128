#!/usr/bin/env sh

echo "article index compiler: compiling article index"
./compile-article-index.sh

echo
echo "article compiler: compiling articles"
./compile-articles.sh

echo
echo "static builder: running packager"
./package.py -s Source -o Public -t "Templates"

