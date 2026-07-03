{% extends "layout.html" %}
{% block title %}About{% endblock %}
{% block content %}

{% for title, content in about|items %}

# >**{{ title }}**

{{ content }}

{% endfor %}

{% endblock %}
