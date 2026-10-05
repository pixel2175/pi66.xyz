{% set title = "About" %}
{% set page_content %}

{% for section in about %}

# >**{{ section.title }}**

{{ section.text }}

{% endfor %}

{% endset %}

{% include "layout.md" %}
