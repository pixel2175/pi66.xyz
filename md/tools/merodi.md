{% extends "layout.html" %}
{% block title %}Walrs{% endblock %}

{% block meta_description %}
Walrs is a lightweight Linux theming tool that extracts colors from wallpapers and applies them system-wide for consistent UI styling across applications.
{% endblock %}

{% block content %}

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

# >**How a build works**

For each markdown file, Merodi:

1. **Escapes fenced/inline code blocks** by wrapping them in Jinja `{% raw %}...{% endraw %}` so any `{{ }}`/`{% %}`-looking text inside code isn't treated as a template expression.
2. **Renders math** — any `$...$` (inline) or `$$...$$` (block) segments are converted to MathML via `latex2mathml`.
3. **Converts Markdown to HTML** using Python-Markdown with the `extra` and `md_in_html` extensions plus a set of `pymdown-extensions` (better emphasis, critic markup, details/summary, syntax highlighting, inline code highlighting, keyboard keys, mark/highlight, superfences, tabbed content, and strikethrough).
4. **Filters stray Jinja artifacts** left behind by the markdown renderer (e.g. `<p>` tags wrapped around `{% %}` block tags) and strips leftover attribute-list brackets after Jinja expressions.
5. **Renders the result through Jinja2**, using your `templates/` directory as the loader root, with every function from `plugins.py` injected as a template global.
6. **Writes the final HTML** to the corresponding path under `dest`, creating directories as needed.

If a build step raises an error, Merodi prints an `[ERROR]`/`[WARN]` line to the terminal; in `webview`/`watch` mode, a styled error page (dark background, red header, offending source line highlighted) is shown in the browser/window instead of crashing the process.

# >**Markdown features**

- **Standard extras** — tables, footnotes, definition lists, fenced code blocks, abbreviations, attribute lists, and more (via Python-Markdown's `extra`)
- **Math** — LaTeX math rendered as MathML (`$...$` inline, `$$...$$` block)
- **Syntax highlighting** — Pygments-based, style configurable via `config.toml`
- **Inline highlights** — `==highlighted text==`
- **Strikethrough** — `~~strikethrough~~`
- **Better emphasis** — smarter handling of `*` and `_`
- **Magic links** — bare URLs auto-link without extra syntax
- **Keyboard keys** — `{++Ctrl+Alt+Del++}` renders styled `<kbd>` elements
- **Details/summary** — collapsible `<details>` blocks
- **Tabbed content** — tabbed code blocks and sections
- **Critic markup** — track suggested edits with `{--delete--}` and `{++add++}`
- **Attribute lists** — Merodi patches this extension to use `[.class]` / `[:#id]` instead of the default `{.class}` / `{:#id}` syntax

# >**Templates**

Pages are rendered with **Jinja2**. Templates live in `src/templates/` (path configurable via `[tree] templates`). Your layout can use any standard Jinja2 block/include/extends behavior.

# >**Plugin functions in templates**

Any public function (no leading underscore) defined in `src/plugins.py` is automatically exposed as a template global:

```jinja
{{ fetch("https://api.example.com/data", type="json") }}
{{ read("src/data/content.txt") }}
```

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
{% endblock %}
