---
layout: page
title: Anecdotes, Opinions and some wild postulations
---
<ul class="posts">
  {% for post in site.posts %}

    {% if post.categories contains "Thoughts" %}
      <li itemscope>
        <a href="{{ site.github.url }}{{ post.url }}"> <h4>{{ post.title }} </h4></a>
        <p> {{ post.content | strip_html | truncate: 150 }} <a href="{{ site.github.url }}{{ post.url }}">Read more</a></p>
        <p class="post-date"><span><i class="fa fa-calendar" aria-hidden="true"></i> {{ post.date | date: "%B %-d %Y" }} - <i class="fa fa-clock-o" aria-hidden="true"></i> {% include read-time.html %}</span></p>
      </li>

    {% endif %}
  {% endfor %}
</ul>
