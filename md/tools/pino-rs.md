{% extends "layout.html" %}

{% block meta_description %}
Pino-rs is a lightweight Rust-based notification daemon for Linux, focused on fast rendering, theming support, and scriptable system notifications.
{% endblock %}

{% block title %} Walrs {% endblock %}

{% block content %}

# >[**Pino**](/tools/pino-rs)

Pino is a fully customizable notification tool rewritten in Rust. It allows you to display notifications with various options, including dynamic theming, configurable fonts, and system integration.

# >**Shortcuts**

- [**Features**](#features)
- [**Installation**](#installation)
- [**Usage**](#usage)
- [**Example: Low Battery Alert**](#example-low-battery-alert)
- [**Configuration**](#configuration)
- [**Dependencies**](#dependencies)
- [**Hardware Usage**](#hardware-usage)

# >**Features** [#features]

- **Customizable Notifications**: Set titles, messages, delay, and fonts.
- **Dynamic Theming with walrs(or pywal)**: Automatically matches the notification theme to your wallpaper.
- **Configurable Settings**: Adjust themes, screen placement, fonts, and more via a TOML config file.
- **Script Integration**: Automate notifications using scripts in any language.

# >**Installation** [#installation]

```sh
make install clean
```

# >**Dependencies** [#dependencies]

Pino requires the following dependencies:

- Rust (for building from source)
- Walrs 
- pywal (optional) for dynamic theming

# >**Usage** [#usage]

Pino supports the following command-line options:

```bash
### Note:
If you want to insert a new line (wrap text) in the message, use `\n` in the argument parameter.
### Example: Low Battery Alert
You can create a script to notify about low battery status:
pino -t "Battery Warning" -m "Low battery!\nPlease connect your charger." -d 5
```

# >**Configuration** [#configuration]

The app uses a TOML configuration file located at `~/.config/pino/config.toml`. Example:

```toml
[screen]
monitor = 0
horizontal = "left"
vertical = "top"
x = 25
y = 55
width = 300
height = 100
delay = 5

[frame]
fg_color = "#1a1e24"
font_family = "Fira Code"

[border]
weight = 4
color = "#ffffff"
radius = 8

[title]
color = "#c5c6c8"
font_size = 19
x = 4
y = 10

[message]
color = "#626977"
font_size = 15
x = 10
y = 45

[pywal]
pywal = false
background_color  = "bg"
border_color      = "color1"
title_color       = "fg"
message_color     = "color8"

[optional]
sound = false
```

# >**Hardware Usage** [#hardware-usage]

Pino is lightweight and efficient. The graphical notification window typically uses approximately **5-20MB of RAM** when active, ensuring minimal system resource consumption.

{% endblock %}  
