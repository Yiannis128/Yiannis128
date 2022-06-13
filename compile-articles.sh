#!/usr/bin/env sh

# Yiannis Charalambous 2021-2022

# Compiles articles from the article directory, turns them into
# html and places them into Source/articles directory.

# Load Scripts
source ./article-compiler-preprocessor.sh

function println() {
    if [ "$VERBOSE" == "1" ]; then
        echo $@
    fi
}

function show_help() {
    echo "compile-articles.sh script by Yiannis Charalambous 2021
    This script is used to convert markdown files into static html files.
    
    Parameters:
        -d|--article-dir=$ARTICLES_DIR
            Set the path of the article directory.
        
        -o|--output-dir=$OUTPUT_DIR
            Set the path of the output directory.
        
        -t|--template-path=$TEMPLATE_FILE
            Set the path to the template html file to use for
            when creating the articles.
                            
        -h|--help   Display help information."
}

ARTICLE_REPLACE_SCRIPT_PATH="article-compiler/article-replace.pl"
ARTICLES_DIR="articles"
OUTPUT_DIR="Source/articles"
TEMPLATE_FILE="article-compiler/article_template.html"
VERBOSE="0"

# Arg processing

ERROR_PARAMS=()
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -d|--article-dir)
            ARTICLES_DIR=$2
            shift # past argument
            shift # past value
            ;;
        -o|--output-dir)
            OUTPUT_DIR=$2
            shift
            shift
            ;;
        -t|--template-path)
            TEMPLATE_FILE=$2
            shift
            shift
            ;;
        -v|--verbose)
            VERBOSE="1"
            shift
            ;;
        -h|--help)
            show_help
            exit
            ;;
        *)
            ERROR_PARAMS+=("$1")
            shift # past argument
            ;;
    esac
done

if [[ "${#ERROR_PARAMS[@]}" -gt "0" ]];
then
    echo "Error: Unknown parameters: ${ERROR_PARAMS[*]}"
    show_help
fi

println "Articles Directory: $ARTICLES_DIR"
println "Output Directory  : $OUTPUT_DIR"
println "Template File     : $TEMPLATE_FILE"
println "Verbosity         : $VERBOSE"
println
println "Starting to compile articles..."
println

compile_article() {
    # Path to the file
    local file_path="$1"
    # Name of the file
    local file_name="$(basename $1)"
    # Output file has md replaced with html extension
    local output_file="$(echo $file_name | sed "s/md$/html/g")"
    local output_path="$OUTPUT_DIR/$output_file"

    # Run the preprocessor to extract all meta data.
    preprocess_article "$(cat $file_path)"
    preprocess_result=$?

    # Create comma separated list from array and dictionary because data needs
    # to be passed to the perl script.
    export param_keys_string="$(param_keys_to_string)"
    export param_values_string="$(param_values_to_string)"

    # NOTE Add built in tags.
    export time="$(expr $(cat $file_path | wc -w) / 200) minutes"
    export html_article="$(cat $file_path | markdown)"
    # Need to remove the param block if the preprocessor found it.
    if [ "$preprocess_result" -eq "0" ]; then
        IFS=$''
        html_article=$(echo $html_article | tail -n +$(($end_line_index+2)))
        unset IFS
    fi

    # Run the perl script that will handle all the replacing.
    #perl "article-compiler/replace.perl"
    perl -p "$ARTICLE_REPLACE_SCRIPT_PATH" "$TEMPLATE_FILE" > $output_path

    println "compiled article: $output_path"
}

# Scan every file and folder inside the articles directory.
for file in $ARTICLES_DIR/*; do
    # Check if the file name ends with md. If it does, then
    # it needs to be compiled, else it needs to be just copied.
    if [[ "$file" == *".md" ]];
    then
        println "compiling: $file"
        compile_article $file
        println
    else
        # If it is a directory then copy the directory.
        if [ -d "$file" ];
        then
            println "copying dir: $file"
            println "to: $OUTPUT_DIR"
            cp -r $file $OUTPUT_DIR
            println
        fi
    fi
done
