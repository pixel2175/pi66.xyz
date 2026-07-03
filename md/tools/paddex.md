{% extends "layout.html" %}
{% block title %} Paddex {% endblock %}
{% block content %}

# >**paddex**

A simple static site generator engine.  
It converts Markdown files into HTML pages using [Jinja2](https://jinja.palletsprojects.com/) templating — configured entirely from a single `config.toml` file.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/pix66)

# >**Build**

```bash
make
```

This will compile the tools and place the binaries in `bin/`.

# >**Clean**

For binaries:
```bash
make clean
```

For generated static files:
```bash
./paddex --clean
```

# >**Config**

Edit `config.toml` to set your variables and paths:

```toml
[context]
name = "Alice"
age  = 18

[settings]
layout_file = "./layout.html"
md_dir      = "./src"
pages_dir   = "./pages"
```

- `[context]` — variables available inside your templates
- `[settings]` — paths used by the engine

# >**Project Structure**

Paddex mirrors your source directory into the output directory:

```
src/
├── index.md              →  pages/index.html
├── about.md              →  pages/about.html
└── tools/
    └── tool.md           →  pages/tools/tool.html
```

Any nesting depth is supported.

# >**Context — Passing Data to Templates**

Everything defined under `[context]` in `config.toml` becomes available in your templates via Jinja2 syntax.

# >**Simple Values**

```toml
[context]
name  = "Alice"
age   = 18
joker = "potato"
```

```html
Hello, {{ name }}!
You are {{ age }} years old.
```

# >**Arrays & For Loops**

```toml
[context]
users = ["Alice", "Bob", "Charlie"]
```

```html
<ul>
{% for user in users %}
  <li>{{ user }}</li>
{% endfor %}
</ul>
```

# >**Tables of Objects**

For structured data, use TOML's array-of-tables syntax:

```toml
[[context.users]]
name = "Alice"
role = "admin"

[[context.users]]
name = "Bob"
role = "editor"
```

```html
{% for user in users %}
  <p>{{ user.name }} — {{ user.role }}</p>
{% endfor %}
```

# >**Nested Tables**

```toml
[context.site]
title       = "My Site"
description = "A cool website"
```

```html
<title>{{ site.title }}</title>
<meta name="description" content="{{ site.description }}">
```

# >**Conditionals**

```html
{% if age >= 18 %}
  <p>Welcome!</p>
{% else %}
  <p>Access denied.</p>
{% endif %}
```

# >**Layouts**

Define a shared base layout in `config.toml`:

```toml
[settings]
layout_file = "./layout.html"
```

Your `layout.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>{{ site.title }}</title>
</head>
<body>
  {% block content %}{% endblock %}
</body>
</html>
```

Extend it in any page:

```html
{% extends "layout.html" %}

{% block content %}
# Hello, {{ name }}!
{% endblock %}
```

# >**HTML in Markdown**

You can freely use raw HTML tags inside `.md` files. They pass through the engine untouched and render correctly in the final output.

```markdown
# My Page

Normal **Markdown** here.

<div class="highlight">
  <p>Raw HTML works fine too.</p>
</div>
```

> HTML tags are not sanitized or stripped — you have full control over your markup.

# >**Quick Reference**

| Feature | Syntax |
|---------|--------|
| Variable | `{{ name }}` |
| For loop | `{% for item in list %}` ... `{% endfor %}` |
| Conditional | `{% if condition %}` ... `{% endif %}` |
| Extend layout | `{% extends "layout.html" %}` |
| Content block | `{% block content %}` ... `{% endblock %}` |
| Nested value | `{{ site.title }}` |

{% endblock %}
