---
layout: page
title: Using clickbaits to share what I have learnt
---
<ul class="posts" list-style-type="circle">
  {% for post in site.posts %}

    {% if post.categories contains "Technical" %}
      <li itemscope>
        <a href="{{ site.github.url }}{{ post.url }}"> <h4>{{ post.title }} </h4></a>
        <p> {{ post.content | strip_html | truncate: 200 }} <a href="{{ site.github.url }}{{ post.url }}">Read more</a></p>
        <p class="post-date"><span><i class="fa fa-calendar" aria-hidden="true"></i> {{ post.date | date: "%B %-d %Y" }} - <i class="fa fa-clock-o" aria-hidden="true"></i> {% include read-time.html %}</span></p>
      </li>

    {% endif %}
  {% endfor %}
</ul>
