{% set metas = {"viewport": "width=device-width, initial-scale=1.0", "description": "A web interface for the pi66.xyz Git server", "author": "Pi66", "theme-color": "#000000"} %}
{% set styles = ["/static/css/style.css"] %}
{% set scripts = ["https://cdn.jsdelivr.net/npm/@tailwindcss/browser", "/static/js/script.js"] %}

{% document title=title|default("Pixel - Git") lang="en" %}
{% for name in metas %}
{% meta name=name content=metas[name] %}
{% endfor %}
{% for href in styles %}
{% style href %}
{% endfor %}
{% for src in scripts %}
{% script src %}
{% endfor %}

<header class="py-2.5 justify-between h-12 px-3 border-[#333] border flex items-center">

[![](/static/icons/lain.gif)](/)

# Pi66 {.pi66-title}

[Home](https://pi66.xyz) | [Repos](https://git.pi66.xyz) | [About](https://pi66.xyz) | [Blog](https://blog.pi66.xyz) | [Gaza](https://pi66.xyz/gaza)

</header>

<main class="p-3 my-2 border border-[#333] overflow-y-scroll">
{{ page_content }}
</main>

<nav>

[Home](https://pi66.xyz) | [Repos](https://git.pi66.xyz) | [About](https://pi66.xyz) | [Blog](https://blog.pi66.xyz) | [Gaza](https://pi66.xyz/gaza)

</nav>

<center>

// Created by **Pi66**

// Copyright ©Pi66 2026
</center>
