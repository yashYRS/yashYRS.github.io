---
layout: page
title: Selected Projects
---
<ul class="posts">
  {% for post in site.posts %}

    {% if post.categories contains "Projects" %}
      {% unless post.next.categories contains "Projects" %}
        <h2>{{ post.date | date: '%Y' }}</h2>
      {% else %}
        {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
        {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
        {% if year != nyear %}
          <h2>{{ post.date | date: '%Y' }}</h2>
        {% endif %}
      {% endunless %}
      
      <li itemscope>
        <h4>{{ post.title }}</h4>
        <p> {{ post.content | strip_html | truncate: 150 }} <a href="{{ site.github.url }}{{ post.url }}">Read more</a></p>
        <p class="post-date"><span><i class="fa fa-calendar" aria-hidden="true"></i> {{ post.date | date: "%B %-d" }} - <i class="fa fa-clock-o" aria-hidden="true"></i> {% include read-time.html %}</span></p>
      </li>

    {% endif %}
  {% endfor %}
</ul>
