#!/usr/bin/env sh

# Compiles articles from the article directory, turns them into
# html and places them into Source/articles directory.

OUTPUT_DIR="Source"
TEMPLATE_FILE="articles/template.html"

compile_article() {
    file="$1"
    # Output file has md replaced with html extension
    output_file="$(echo $file | sed "s/md$/html/g")"
    output_path="$OUTPUT_DIR/$output_file"
    export html_file="$(markdown $file)"
    # Get the title of the article to substitute into the template.
    export html_title="$(head -n 1 $file | sed 's/# //g')"
    
    perl -pe '
        s/{title}/$ENV{html_title}/g;
        s/{article}/$ENV{html_file}/g;
    ' "$TEMPLATE_FILE" > $output_path

    echo "compiled article: $output_path"
}

for file in articles/*.md;do
    echo "compiling: $file"
    compile_article $file
done

echo