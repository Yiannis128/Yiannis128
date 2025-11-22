# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal website built with Hugo static site generator. The site showcases research papers, articles, projects, and tools. It uses a custom theme called "newblue" located in `themes/newblue/`.

## Build Commands

- **Build the site**: `hugo` (or use `./build.sh` which cleans and rebuilds)
- **Clean build artifacts**: `./clean.sh` (removes the `public/` directory)
- **Development server**: `hugo server` (live reload at http://localhost:1313)
- **Upload to production**: `./upload.sh` (uses rsync to deploy to remote server)

## Architecture

### Content Structure

The site uses Hugo's content organization:

- **Articles** (`content/articles/`): Blog posts and tutorials organized hierarchically with support for subcategories
- **Projects** (`content/projects/`): Portfolio items with custom frontmatter including `section` (year) and `subsection` (ordering)
- **Home** (`content/_index.md`): Landing page with research papers, tools, and software/hardware lists

### Theme Organization

The site is theme-compatible. Custom layouts and data are stored within the theme directories, allowing easy theme switching:

- **newblue theme**: Contains custom layouts (`themes/newblue/layouts/`) and data (`themes/newblue/data/`)
- **hugo-xmin theme**: Minimal theme available for testing theme compatibility
- No root `layouts/` or `data/` directories - everything is theme-specific

### Data-Driven Content (newblue theme)

The homepage in newblue theme is data-driven using TOML files in `themes/newblue/data/`:

- `themes/newblue/data/tools.toml`: Contains three arrays:
  - `tool`: Projects created by the author
  - `sw_use`: Software used/recommended
  - `hw_use`: Hardware used/recommended
- `themes/newblue/data/research.toml`: Contains research papers
- `themes/newblue/data/about.toml`: About page information

### Layout System (newblue theme)

Custom layouts in `themes/newblue/layouts/`:

- `_default/baseof.html`: Base template with CSS asset pipeline using `resources.Get` and Hugo Pipes
- `index.html`: Home page template that renders data from TOML files
- `articles/list.html`: Article listing with RSS feed link, sections, and tag cloud
- `articles/single.html`: Individual article view with navigation, reading time, and tags
- `projects/list.html`: Projects organized by year with support for special "showcase" view using `Params.view`

Projects support two display modes:
1. **Standard**: Regular content cards with links, images, and videos
2. **Showcase**: Full-width background image cards (controlled by `view: "showcase"` in frontmatter)

### Theme

The custom "newblue" theme provides:
- CSS files in `themes/newblue/assets/css/`: `main.css`, `navbar.css`, `footer.css`, `Holiday.css`
- Custom layouts in `themes/newblue/layouts/` (see Layout System above)
- Data files for homepage content in `themes/newblue/data/`

### Partials (newblue theme)

Reusable components in `themes/newblue/layouts/partials/`:
- `navbar.html`: Site navigation from `hugo.toml` menu config
- `footer.html`: Site footer
- `thumbnail.html`: Displays featured images for content
- `article_nav.html`: Navigation between articles
- `link_button.html`: Renders link buttons for projects
- `mathjax_support.html`: Mathematical notation support (enabled via `mathjax: true` in frontmatter)

### Configuration

`hugo.toml` settings:
- Uses ugly URLs (`uglyurls = true`) generating `.html` extensions
- Custom theme: `newblue`
- Unsafe HTML rendering enabled for goldmark
- Syntax highlighting with monokai theme, line numbers in tables
- Taxonomies: Only tags are enabled (categories disabled)

## Important Notes

- The site is **theme-compatible**: all custom layouts and data are stored within theme directories
- To test with different themes: `hugo build -Dt <theme-name>`
- The site generates `.html` files due to `uglyurls = true` setting
- Articles can be nested in subdirectories to create categories
- Projects use `section` (year) and `subsection` (number) params for ordering
- MathJax support must be explicitly enabled per page with `mathjax: true` in frontmatter (newblue theme)
- CSS is processed through Hugo Pipes with minification and fingerprinting (newblue theme)
- The `public/` directory is gitignored and regenerated on each build
