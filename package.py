#!/usr/bin/env python3

# HTML Packager is made by Yiannis Charalambous - 2020

from io import TextIOWrapper
import os
from sys import argv
from shutil import copyfile
from pathlib import Path
from bs4 import BeautifulSoup, Tag

verbose : bool = False

def print_debug(*args):
    if verbose:
        print(*args)

def create_directory(dir : str):
    p : Path = Path(dir)
    p.mkdir(parents=True, exist_ok=True)

def get_build_path(path : str) -> str:
    return path.replace(source_folder, build_folder, 1)

def copy_file(dir : str, file : str) -> None:
    file_path = os.path.join(dir, file)
    build_file_path = get_build_path(file_path)
    build_path = get_build_path(dir)

    print_debug("    Copying File: " + file_path)
    print_debug("Target Directory: " + build_file_path)
    print_debug()

    # Make the path if it doesn't exist
    create_directory(build_path)
    copyfile(file_path, build_file_path)

# Replace all occurances of the import start tag and end tag
# with the content that it points to.
def parse_file(templates_path : str, content : str) -> str:
    # Begin parsing of HTML file...
    soup = BeautifulSoup(content, "html.parser")

    # Find all the import tags.
    import_tag : Tag
    for import_tag in soup.findAll(import_tag_name):
        # Get the file path of the include file.
        import_file_path = import_tag.attrs["src"]

        # Open the file and read content.
        import_file : TextIOWrapper = open(os.path.join(templates_path, import_file_path), mode="r")
        import_content : str = import_file.read()

        # Add the content of the file in the area where the tag was.
        imported_soup : BeautifulSoup = BeautifulSoup(import_content, "html.parser")
        import_tag.replace_with(imported_soup)

    result : str = str(soup)

    return result

def scan_file(dir : str, path : str) -> None:
    print_debug("   Scanning File: " + path)

    # Calculate build path.
    build_path : str = get_build_path(dir)
    build_file_path : str = get_build_path(path)

    file : TextIOWrapper = open(path, mode="r")
    content : str = file.read()
    build_content = parse_file(os.path.join(dir, templates_folder), content)

    # Make the path if it doesn't exist
    create_directory(build_path)

    # Write content to the build directory.
    build_file : TextIOWrapper = open(build_file_path,'w')
    build_file.write(build_content)

    print_debug("   Building File: " + build_file_path)
    print_debug()

def scan_directory(path : str) -> None:
    # Walk through the files...
    for subdir, _dirs, files in os.walk(path):
        for file in files:
            # Only scan the file if it has the correct file format.
            splitext : str = os.path.splitext(file)
            extension : str = splitext[len(splitext) - 1]

            file_path = os.path.join(subdir, file)

            if extension in allowed_file_formats:
                scan_file(subdir, file_path)
            else:
                # Just copy the file.
                copy_file(subdir, file)

base_directory : str = os.getcwd()
source_folder : str = "Source"
build_folder : str = "Public"
templates_folder : str = "Templates"

import_tag_name : str = "import"

allowed_file_formats = [".html"]

if __name__ == "__main__":
    # Parse commandline arguments.
    if len(argv) != 3:
        print("Wrong number of arguments.")
        print("Usage: [Source] [Target]")
        exit(1)

    source_folder = argv[1]
    build_folder = argv[2]

    print_debug("Base Directory: " + base_directory)
    print_debug("Source Folder: " + source_folder)
    print_debug("Build Folder: " + build_folder)
    print_debug()

    scan_directory(source_folder)


