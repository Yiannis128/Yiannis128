#!/usr/bin/env python3

from io import TextIOWrapper
import os
from shutil import copyfile
from pathlib import Path
from bs4 import BeautifulSoup, Tag

def create_directory(dir : str):
    p : Path = Path(dir)
    p.mkdir(parents=True, exist_ok=True)

def get_build_path(path : str) -> str:
    return path.replace(source_folder, build_folder, 1)

def copy_file(dir : str, file : str) -> None:
    file_path = os.path.join(dir, file)
    build_file_path = get_build_path(file_path)
    build_path = get_build_path(dir)

    print("    Copying File: " + file_path)
    print("Target Directory: " + build_file_path)
    print()

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

    return str(soup)

def scan_file(dir : str, path : str) -> None:
    print("   Scanning File: " + path)

    # Calculate build path.
    build_path : str = get_build_path(dir)
    build_file_path : str = get_build_path(path)

    file : TextIOWrapper = open(path, mode="r")
    content : str = file.read()
    build_content = parse_file(os.path.join(source_folder, templates_folder), content)

    # Make the path if it doesn't exist
    create_directory(build_path)

    # Write content to the build directory.
    build_file : TextIOWrapper = open(build_file_path,'w')
    build_file.write(build_content)

    print("   Building File: " + build_file_path)
    print()

def scan_directory(path : str) -> None:
    # Walk through the files...
    for subdir, dirs, files in os.walk(path):
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

allowed_file_formats = [".html", ".css", ".js"]

print("Base Directory: " + base_directory)
print("Source Folder: " + source_folder)
print("Build Folder: " + build_folder)
print()

if __name__ == "__main__":
    scan_directory(source_folder)