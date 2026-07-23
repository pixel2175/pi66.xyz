{% set page_title = "About" %}
{% set page_content %}

{% for title, content in about|items %}

# >**{{ title }}**

{{ content }}

{% endfor %}

{% endset %}

{% include "base.html" %}
