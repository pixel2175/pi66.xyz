{% extends "layout.html" %}
{% block title %}Tools{% endblock %}

{% block content %}

# >**My Tools & Apps**

Select a tool to explore:

<div class="my-8 grid  grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-3 gap-4" markdown=1>

{% for tool, description in my_tools|items %}

<div class="px-3 pb-3 border border-[#333]  hover:border-green-700   duration-100 rounded" markdown=1>

# >[**{{tool}}**](/tools/{{ tool | lower }}) [.!text-2xl .![text-decoration-color:#000] .border-b]

{{ description }}

</div>

{% endfor %}

</div>

# >**Coming Soon**

> Under Construction :)

{% endblock %}
