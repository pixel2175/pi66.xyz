{% set page_title = "Merodi" %}

{% set page_meta_description %}
A markdown-based static site generator built with Python. Write pages in markdown, style them with Jinja2 templates, and get a ready-to-publish website.
{% endset %}

{% set page_content %}

# >[**Merodi**](/tools/merodi)

**Merodi** is a markdown-based static site generator written in Python. Write pages in Markdown, style them with Jinja2 templates, and get a ready-to-publish website — with live preview via a watcher or a native webview window.

# >**Install**

```bash
pip install .
# or using pipx
pipx install .
```

Requires **Python ≥ 3.11**. Dependencies: `markdown`, `jinja2`, `pywebview`, `watchdog`, `PyGObject`, `pymdown-extensions`, `latex2mathml`, `pygments`.

# >**Quick start**

```bash
merodi init my-site
cd my-site
merodi build
```

Open `src/dest/index.html`, or run `merodi webview` for a live preview window, or `merodi watch` to rebuild on file changes without opening a window.

# >**Project structure**

`merodi init` scaffolds:

```
my-site/
  config.toml
  src/
    md/
      index.md
    templates/
      layout.html
    static/
      style.css
    plugins.py
    dest/
```

- `src/md/index.md` — default page, a single Jinja `content` block with `# Hello, Alice`
- `src/templates/layout.html` — base HTML layout with a `title` block, a `content` block, and a `style_css` variable wired to the stylesheet
- `src/static/style.css` — minimal default styling
- `src/plugins.py` — Python functions exposed to templates (see below)
- `src/dest/` — build output directory

# >**Commands**

# >**merodi init [path]**

Creates `config.toml` and the default project tree shown above. Fails if `config.toml` already exists at the target path.

# >**merodi build [path]**

Builds every markdown file under `tree.markdown` into HTML files under `tree.dest`, preserving the relative folder structure.

| Flag | Description |
|------|-------------|
| `--file SRC DEST` | Build a single markdown file directly to a destination path (cannot be combined with a project path) |
| `--release` / `--debug` | Build mode flag (currently reserved for future use) |

# >**merodi watch [path]**

Watches `markdown`, `templates`, `static`, and the `plugins.py` file for changes and rebuilds the affected page automatically. This runs headless (no window) — useful for pairing with your own dev server or editor live-reload setup. Changes are debounced (~0.3s) to avoid duplicate rebuilds from rapid file-system events.

# >**merodi webview [path]**

Starts a local HTTP server (serving `dest` at `html_path` and `static` at `static_path`), opens a native GUI window pointed at it, and watches files the same way `watch` does — reloading the window automatically when markdown, templates, static assets, or plugins change.

# >**Global flags**

| Flag | Description |
|------|-------------|
| `--verbose` | Show detailed error information (also via `VERBOSE=true`) |
| `--no-color` | Disable colored terminal output (also via `NO_COLOR=true`) |

# >**How the build process works**

For each Markdown file, Merodi performs the following steps:

1. **Protects code blocks** by preventing Jinja syntax inside fenced and inline code from being evaluated during template rendering.
2. **Renders LaTeX math** by converting inline (`$...$`) and block (`$$...$$`) expressions into MathML using `latex2mathml`.
3. **Converts Markdown to HTML** with Python-Markdown, using the `extra` and `md_in_html` extensions together with several `pymdown-extensions` for enhanced formatting, syntax highlighting, tabbed content, critic markup, keyboard keys, and more.
4. **Cleans the generated HTML** by removing Markdown artifacts that can interfere with Jinja rendering, such as unwanted `<p>` tags around template statements and leftover attribute-list markers.
5. **Renders the page with Jinja2**, loading templates from the configured `templates/` directory and exposing every public function from `plugins.py` as a template global.
6. **Writes the finished HTML** to the corresponding location in the output directory, creating any missing directories automatically.

If any step fails, Merodi reports the error in the terminal. When running in `watch` or `webview` mode, it displays a formatted error page highlighting the offending source line instead of terminating the process.

# >**Markdown features**

Merodi extends standard Markdown with a collection of built-in features:

* **Python-Markdown Extras** — tables, footnotes, definition lists, fenced code blocks, abbreviations, attribute lists, and other extensions provided by `extra`.
* **LaTeX Math** — inline (`$...$`) and block (`$$...$$`) expressions rendered as MathML.
* **Syntax Highlighting** — powered by Pygments, with the style configurable in `config.toml`.
* **Inline Highlighting** — `==highlighted text==`.
* **Strikethrough** — `~~strikethrough~~`.
* **Improved Emphasis** — more reliable parsing of `*` and `_`.
* **Automatic Links** — plain URLs are converted into clickable links.
* **Keyboard Keys** — `{++Ctrl+Alt+Del++}` rendered as styled `<kbd>` elements.
* **Details & Summary** — native support for collapsible `<details>` sections.
* **Tabbed Content** — create tabbed layouts for code blocks and other content.
* **Critic Markup** — annotate additions, deletions, substitutions, and comments using Critic Markup syntax.
* **Modified Attribute Lists** — uses `[.class]` and `[:#id]` instead of Python-Markdown's default `{.class}` and `{:#id}` syntax to avoid conflicts with Jinja templates.

# >**Templates**

Pages are rendered with **Jinja2**. Templates live in `src/templates/` (path configurable via `[tree] templates`). Your layout can use any standard Jinja2 block/include/extends behavior.

# >**Plugin functions in templates**

Any public function (no leading underscore) defined in `src/plugins.py` is automatically exposed as a template global:

{% raw %}

```jinja
{{ fetch("https://api.example.com/data", type="json") }}
{{ read("src/data/content.txt") }}
```
{% endraw %}

The default `plugins.py` ships two functions:

- **`fetch(url, type="text")`** — performs an HTTP GET; returns parsed JSON if `type="json"`, otherwise raw text (trailing newline stripped). Raises if the response status isn't 200.
- **`read(file)`** — reads a local file's contents as text (trailing newline stripped).

Add your own functions to `plugins.py` and they'll be available the same way — no registration step needed.

# >**Configuration**

Project settings live in `config.toml`, at the project root:

```toml
[project]
name        = "my-site"
version     = "0.1.0"
description = "Add your description here"

[tree]
markdown  = "src/md"
static    = "src/static"
templates = "src/templates"
dest      = "src/dest"
plugins   = "src/plugins.py"

[webview]
host        = "localhost"
port        = 8866
dev_tools   = false
html_path   = "/"
static_path = "/static"

[extras]
highlight = "monokai"
```

# >**[project]**

Metadata only — name, version, description. Not currently used to alter build behavior.

# >**[tree]**

Paths (relative to the project root) for where Merodi looks for input and writes output. All five must exist (except `dest`, which is created automatically if missing) or the build fails with a `FileNotFoundError`.

# >**[webview]**

| Key | Default | Description |
|-----|---------|-------------|
| `host` | `"localhost"` | Host the local HTTP server binds to |
| `port` | `8866` | Port the local HTTP server binds to |
| `dev_tools` | `false` | Enables pywebview's debug mode / dev tools when running `webview` |
| `html_path` | `"/"` | URL prefix that serves built HTML from `dest` |
| `static_path` | `"/static"` | URL prefix that serves files from `static` |

# >**[extras]**

| Key | Default | Description |
|-----|---------|-------------|
| `highlight` | `"monokai"` | Pygments style name for syntax highlighting. Set to `"noclasses"` to emit CSS classes (for external stylesheets) instead of inline styles. |

# >**Architecture (source layout)**

| File | Responsibility |
|------|---------------|
| `main.py` | CLI entry point — argument parsing and command dispatch (`init`, `build`, `watch`, `webview`) |
| `init_project.py` | Scaffolds a new project: writes `config.toml` and default md/template/CSS/plugin files |
| `build.py` | Core markdown → HTML pipeline (code-escaping, math, Markdown extensions, Jinja rendering, plugin loading) |
| `watcher.py` | File-system watcher (via `watchdog`) that triggers incremental rebuilds |
| `webviewer.py` | Local HTTP server + native window (via `pywebview`) with live reload |
| `config.py` | Loads/parses `config.toml` into typed config objects; generates default config content |
| `modules.py` | Dataclasses for `Project`, `Tree`, `Webview`, `Extras`, and the top-level `Config` |
| `fileops.py` | Small file read/write helpers and tree-directory creation |
| `templates.py` | Default file contents written by `merodi init` (markdown, layout, CSS, plugins) |
| `errors.py` | Error formatting — terminal output and the in-browser styled error page |
| `log.py` | Colored `[INFO]` / `[WARN]` / `[ERROR]` console logging, toggled by `--no-color` |
| `settings.py` | Global `VERBOSE` / `NO_COLOR` flags set from CLI args or environment variables |

> **Note:** Merodi is under active development (currently v0.2.0). The `--release`/`--debug` build flags are parsed but not yet acted upon.
{% endset %}

{% include "base.html" %}
