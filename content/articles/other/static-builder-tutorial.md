---
title: "Static Builder Tutorial"
date: 2022-06-14T17:55:02+01:00
draft: false
---

This tutorial will look at how Static Builder works and will also act as a guide on how to
set it up and use it. Static builder is a tool written in Python3 that allows for the reuse
of common elements in static websites. For example, without it, changing the header bar in one
webpage, will not change it in all the others, Static Builder is designed to fix this issue,
and hence speed up the workflow and hopefully lessen the more mundane parts of the creation
process.

Static Builder can be obtained via GitHub.

[GitHub](https://github.com/Yiannis128/StaticBuilder)

## Installation
It is very easy to add Static Builder to a website. The script is self contained, so it
can be placed in the root folder of the website.

## Example Usage
The best way to demonstrate the power behind Static Builder is to create a template of the
navigation bar of your website as it is probably the most reused html code. Start by
creating a folder in the same folder as your HTML files and naming it "Templates". All the
reusable HTML will be placed in this folder. Create a new file inside the Templates folder
naming it "Header.html".

Copy all the HTML code that creates your navigation bar and paste it into Header.html. Now
replace the HTML code that was your header with the following HTML tag:

`<import src="Header.html"/>`

Next, run the script providing as the first argument the path to the folder where all the
HTML code resides, the second argument needs to be the path a folder where the generated
HTML will be placed. In my case, the development folder of my website is `Source`
and the folder that is used for viewing the page during development and when it is to be
uploaded to the server is `Public`.

`./packager.py Source Public`

When the script finishes execution, the generated website will contain
the navigation bar inside it instead of the import tag. Adding import tags to the rest of
the pages and removing the HTML navigation bar code will allow for HTML code reuse. When a
change is needed to be made to the navigation bar, all that is needed to be done, is a change
to `Header.html` and an execution of Static Builder and the changes of the navigation
bar will propagate through the whole site.

It is worth noting that import tags can only be placed in HTML files. Furthermore, due to
the way that Static Builder works, having relative references (to resources and other) in template
files does not work as when the file is copied it may break the reference. So it is recommended to
either use absolute referencing or to have a Template folder in each directory that contains all the
templates that each directory needs. This may change in the future, when a good solution is found.
