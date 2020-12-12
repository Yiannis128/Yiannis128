#!/usr/bin/env bash

echo "Running packager"
./packager.sh

echo "Building latest tailwindcss..."
npx tailwindcss-cli@latest build Source/Styles/Styles.css -o Public/Styles/Styles.css