#!/usr/bin/env bash

echo "Running packager"
./package.py

echo "Building latest tailwindcss..."
npm run build-css