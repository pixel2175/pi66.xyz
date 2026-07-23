{% set page_title = "Walrs" %}

{% set page_meta_description %}
Walrs is a lightweight Linux theming tool that extracts colors from wallpapers and applies them system-wide for consistent UI styling across applications.
{% endset %}

{% set page_content %}

# >[**Walrs**](/tools/walrs)

A fast, lightweight color scheme generator written in Rust.

Walrs extracts colors from an image and applies them across your desktop, providing a workflow similar to Pywal while focusing on speed, simplicity, and accurate color generation.

# >**Features**

- Rust implementation with minimal resource usage
- Up to **10× faster** than Pywal
- Better color accuracy than Wallust
- Adjustable brightness and saturation
- Template generation for applications
- Wallpaper management
- Shell completion support (Bash, Zsh, Fish)
- Theme import and export
- Quiet mode for scripting

# >**Usage**

# >**Generate colors from an image**

```bash
walrs -i ~/Pictures/wallpaper.png
```

# >**Generate and save a theme**

```bash
walrs -g my-theme -i wallpaper.png
```

# >**Apply a saved theme**

```bash
walrs -t my-theme
```

# >**Reload templates**

```bash
walrs --reload
```

# >**Command Line Options**

<div class="px-33 max-lg:px-0" markdown=1>

| Option | Description |
|--------|-------------|
| -i <IMAGE> | Generate a color scheme from an image. |
| -r, --reload | Reload templates and set the wallpaper. |
| -R, --Reload | Reload templates without changing the wallpaper. |
| -t, --theme <THEME> | Load a saved theme. |
| -g, --generate <NAME> | Generate and save a theme. |
| -s, --saturation <VALUE> | Set saturation (-128 to 127). |
| -b, --brightness <VALUE> | Set brightness (-128 to 127). |
| -q, --quit | Suppress terminal output. |
| --install-completions | Install shell completions. |
| -h, --help | Show the help message. |
| -V, --version | Show the current version. |

</div>

# >**Installation**

# >**AUR**

```bash
yay -S walrs
```

# >**Build from source**

```bash
git clone https://github.com/pixel2175/walrs
cd walrs
make install
```

# >**Performance**

| Metric | Value |
|--------|-------|
| Memory Usage | ~3 MB |
| Processing Time | ~290 ms for a 1080p (1.5 MB) image |
| Language | Rust |
| Dependencies | Wallpaper setter (feh, swww, xwallpaper, etc.) |

# >**Example Output**

```text
[I] Generate: generating colors...
[I] Template: rendering templates...
[I] Wallpaper: wallpaper applied.
[I] Terminal: colors updated.
[I] Xrdb: database updated.
[I] Colors: completed successfully.
```

# >**Benchmark**

```text
Executed in 376.01 ms

User:   236.90 ms
System: 132.21 ms
```

{% endset %}

{% include "base.html" %}
