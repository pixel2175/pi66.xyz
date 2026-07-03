{% extends "layout.html" %}

{% block title %} STA {% endblock %}

{% block meta_description %}
STA is a lightweight, fast, and modular system tool designed for automation, analysis, and integration into Linux-based workflows. This documentation covers installation, usage, configuration, CLI commands, and architecture.
{% endblock %}

{% block content %}

# >[**Sta**](/tools/sta)

**STA** is a minimal status monitor app written in C.

# >**About**

STA is inspired by slstatus. The core code is fully rewritten; only the config structure (with some edits) and the status-fetching functions are from slstatus.

# >**How it works**

STA runs as a server (daemon) using a UNIX socket and waits for updates from clients.

You can update any status by specifying its ID from the config file, then run:

```
sta -id <ID>
```

This sends a signal to the socket and refreshs the status.

You can configure the displayed status in `config.def.h`.

# >**Example**

```bash
# Start the server
sta -s

# Send a status update
sta -id 1

# Update the status value
sta -id 1 -name "value"
```

This sends the current time (or other info) to the server with a unique ID.
Rerun the command whenever you want to update the status.

# >**Update Intervals**

Each status entry defined in `config.def.h` has a `delay` value, specified in **milliseconds**.
This value controls whether — and how often — STA refreshes that status automatically.

- **`delay == 0`** → The status is fetched **once**, at server startup, and is **not** refreshed automatically afterwards. It only updates when you manually trigger it with:
```bash
  sta -id <ID>
```
- **`delay > 0`** → STA spawns a dedicated background thread for that status, which refreshes it automatically every `delay` ms, without needing any client call.

This lets you mix static or manually-updated entries (e.g. a custom value set via `-name`) with entries that need to stay live, like a clock or system stats, while keeping idle statuses from being recomputed needlessly.

# >**Example**

```c
{ get_time     , "%s", "%H:%M", 1, 1000 },   // updates every second automatically
{ get_hostname , "%s", NULL   , 2, 0 },     // fetched once, updated manually via `sta -id 2`
```

> **Note:** STA was created for learning purposes.
{% endblock %}
