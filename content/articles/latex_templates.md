---
title: "LaTeX Stuff"
date: 2024-07-04T13:16:47+01:00
draft: false
tags:
- Notes
---

This article is split into two sections. My favorite Linux [Templates](#templates) and [Definitions](#definitions).

## Templates

This will be updated when I find new ones. Keep an eye out 👀

### Beamer

* [A Really Simple, Minimalistic Beamer Theme](https://www.overleaf.com/latex/examples/a-really-simple-minimalistic-beamer-theme/tfgnwbcxbyvp)
* [Simple Beamer Theme](https://www.overleaf.com/latex/templates/simple-beamer-theme/cyjyxkdttqzs)

---

## Definitions

Initially when I started using LaTeX, I was using all the built-in functions with the help of the internet to do what I need. In the rare occasion when I needed to do something specific that the commonly defined LaTeX environment did not accommodate for, I would search online. But that rarely worked. I still don't know why, perhaps I was using the code given to me wrongly. I just couldn't (and still can't) read style code for LaTeX documents.

LaTeX is a powerful language, it can do many things. From creating figures, to the actual diagrams themselves, to creating full on animated presentations, the only constraints faced by the authors are the page dimensions themselves. The main issue, lies in knowing how LaTeX documents are laid out, and built. Now that I am more comfortable with the syntax, I have progressed into learning how to create commands and how they work. It is very useful to know how to define commands and environments because it will massively boost your workflow.

### Useful Definitions

I have begun collecting all the common definitions I have defined, because I might need to reuse them in future projects. Below are some useful definitions that I have created, this will be updated automatically as I update the definitions. So you can bookmark the page, or follow the gist on GitHub 😉.

<script src="https://gist.github.com/Yiannis128/5cf8f87af40b8937ba407ab9a0d3e386.js"></script>


Installation is very simple, simply download the files, and save them in the root directory of your project. Include the code below to add them into your document:

```tex
\input{defs}
\input{beamerdefs}
```

### Future Goal

Currently, I would say the code I write is minimally original. Even the code I have linked above is very simple, so arguably original. My future goal is to learn how to use LaTeX, to the point where I do not require help, and can come up with my own styles/code.
