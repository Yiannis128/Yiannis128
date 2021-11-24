#!/usr/bin/env sh

# Yiannis Charalambous 2021

# Compiles articles from the article directory, turns them into
# html and places them into Source/articles directory.

ARTICLES_DIR="articles"
OUTPUT_DIR="Source/articles"
TEMPLATE_FILE="article_template.html"

# TODO Add argument processing

compile_article() {
    # Path to the file
    file_path="$1"
    # Name of the file
    file="$(basename $1)"
    # Output file has md replaced with html extension
    output_file="$(echo $file | sed "s/md$/html/g")"
    output_path="$OUTPUT_DIR/$output_file"
    export html_file="$(markdown $file_path)"
    # Get the title of the article to substitute into the template.
    export html_title="$(head -n 1 $file_path | sed 's/# //g')"
    
    # This embedded perl script scans every line for a title and article tag
    # and substitutes it with the html file content. It then pipes it into
    # the output path.
    perl -pe '
        s/{title}/$ENV{html_title}/g;
        s/{article}/$ENV{html_file}/g;
    ' "$TEMPLATE_FILE" > $output_path

    echo "compiled article: $output_path"
}

# Scan every file and folder inside the articles directory.
for file in $ARTICLES_DIR/*; do
    # Check if the file name ends with md. If it does, then
    # it needs to be compiled, else it needs to be just copied.
    if [[ "$file" == *".md" ]];
    then
        echo "compiling: $file"
        compile_article $file
        echo
    else
        # If it is a directory then copy the directory.
        if [ -d "$file" ];
        then
            echo "copying dir: $file"
            echo "to: $OUTPUT_DIR"
            cp -r $file $OUTPUT_DIR
            echo
        fi
    fi
done


