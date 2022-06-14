---
title: "Article Compiler Tutorial"
date: 2022-06-14T17:55:51+01:00
draft: false
---

This tutorial will look at how to setup article compiler so that it compiles
markdown articles inside a folder and outputs them as HTML in another folder,
along with how the template system works. Article compiler can be obtained on
[GitHub](https://github.com/Yiannis128/article-compiler).

## Requirements

Article Compiler uses the following programs:

- Perl

## Installation

Article compiler is basically a script, so once you download/clone the git repo,
just copy the `compile-articles.sh` script into a place where you will want to
use it. In my case, the website repository contains `compile-articles.sh` at the
root, the website contents, that is, HTML, CSS and files that belong to the
website are inside a `Source` folder.

## Workflow

First Article Compiler compiles the articles and places them in a folder inside
of Source, then [Static
Builder](https://yiannis-charalambous.com/articles/static-builder-tutorial.html)
takes the Source folder and builds the website, this forms a small pipeline.
It can be automated with a shell script like this:

    #!/usr/bin/env sh

    echo "Compiling articles"
    echo
    ./compile-articles.sh

    echo "Running packager"
    ./package.py Source Public

So running `build.sh` (that is what I call the script) will run both article
compiler and static builder in one command.

## Article Template

The template file will allow the HTML generated to be of the same format as
the rest of the website, instead of the generated HTML being just a bunch of
HTML tags that don't really resemble the webpage that an article could be found
in. Here is the template for this website:

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Yiannis CS - {title}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <import src="Common.html" />

    </head>

    <body>
        <import src="Header.html" />

        <main>
            <div class="ContentCard">
                <div class="ContentCardSection">
                    <h1>{title}</h1>
                    <h4>Reading Time: {time}</h4>
                    {article}
                </div>
            </div>
        </main>

        <import src="Footer.html" />
    </body>

    </html>

_Note that the import elements are for [Static Builder](static-builder-tutorial.html)._

The HTML is normal aside from the `{title} {article} {time}` keywords. These
keywords let Article Compiler insert the title of the article and the generated
HTML at the correct place. The `{article}` tag is replaced by the content of the
markdown file (aside from the param block that will be explained later). The
`{time}` tag is automatically calculated by the word count of the markdown file.
The `{title}` tag is obtained from the inclusion of a _title_ field inside of
the param block at the top of the file.

## The Param Block

The param block is a block of meta data that is included at the top of the
markdown file, it is removed when the article is compiled so the HTML will not
include it. Inside the param block, meta data such as the title of the article
can be included. The param block needs to start at the first line of the file,
that means that the `params` keyword is at line 0 of the markdown file, if this
is not the case, then article compiler will treat the param block as being part
of the file and include it in the generated HTML. An example param block is
shown below:

    params
    title: Article Compiler Tutorial
    endparams

The param block starts with the `params` keyword and ends with the `endparams`
keyword. Between those two keywords, meta data such as what the title of the
article is can be declared in the form of `key: value`. Each meta data entry,
along with the `params endparams` keywords need to be line separated.

## Supported Tags

Below is a list of currently supported tags that are supported.

| Markdown Tag | HTML Template Tag | Explanation                                         |
| ------------ | ----------------- | --------------------------------------------------- |
| N/A          | article           | The article will be placed where the tag is.        |
| title        | title             | The title of the article.                           |
| N/A          | time              | Time to read the article, automatically calculated. |

_More are planned on being added depending on how neccessary they are as a
design decision of this script is to keep it minimalistic._

## Example Usage

Create an empty folder, this will resemble the root of our website repo. Inside
folder create these folders:

- `articles`
- `Source`
- Inside the `Source` folder, create a `articles` folder.

Inside the root of the website, create a template file, the default accepted
file is `article_template.html` although it can be changed by supplying the
script with arguments. Now create an article such as `test.md` and save it
inside `articles`. Run the `./compile-articles.sh` script and it will take the
articles inside the `articles` folder and create HTML webpages using the
template and save them inside of `Source/articles`.

