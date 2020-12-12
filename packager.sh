#!/usr/bin/env bash

# Port of WebKitBuilder to Linux.
# Usage: packager.sh <Source Directory> <Build Directory> <Start Symbol> <End Symbol>
# Defaults: packager.sh Source Public @( )@

#function scan_file()

function scan_file()
{
    file="$1"
    echo "--Scanning file: $file"

    
}

function scan_directory()
{
    current_directory="$1"

    # Iterate through all the files in the directory...
    for file in "$current_directory/"*
    do
        if [ -d "$file" ]
        then
            # Is a directory, so scan it.
            scan_directory $file
        elif [ -f "$file" ]
        then
            # Is a file, so scan it.
            scan_file $file
        fi
    done
}

source_directory="Source"
build_directory="Public"

macro_start="@("
macro_end=")@"

echo "Working Directory: $(pwd)"
echo

# Begin scan.
scan_directory "$(pwd)/$source_directory"
