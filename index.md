---
layout: default
---

<div class="home">

  <h1 class="page-heading">Dark Acre Church</h1>
  
  <h2>Episode List</h2>
  
  <ul class="post-list">
    {% assign church-episodes = site.episodes | where: "show", "church" | sort: "date" | reverse %}
    {% for episode in church-episodes %}
      <li>
        <span class="post-meta">{{ episode.date }}</span>
        <a class="post-link" href="{{ episode.url | prepend: site.baseurl }}">{{ episode.title }}</a>       
      </li>
    {% endfor %}
  </ul>

  <p class="rss-subscribe">subscribe <a href="{{ "/feed.xml" | prepend: site.baseurl }}">via RSS</a></p>

</div>