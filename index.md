---
layout: default
---

<div class="home">

  <h1 class="page-heading">Dark Acre Church</h1>
  
  <h2>Episode List</h2>
  
  <ul class="post-list">
    {% assign church-episodes = site.episodes | where: "category", "church" | sort: "date" | reverse %}
    {% for episode in church-episodes %}
      <li>
        <span class="post-meta">{{ episode.date | date_to_string }}</span>
        <a class="post-link" href="{{ episode.url | prepend: site.baseurl }}">{{ episode.show_name | capitalize }}: {{ episode.title | xml_escape }}</a>       
      </li>
    {% endfor %}
  </ul>
  
  <h2>Unplayed List</h2>
  
  <ul class="post-list">
    {% assign unplayed-episodes = site.episodes | where: "category", "unplayed" | sort: "date" | reverse %}
    {% for episode in unplayed-episodes %}
      <li>
        <span class="post-meta">{{ episode.date | date_to_string }}</span>
        <a class="post-link" href="{{ episode.url | prepend: site.baseurl }}">{{ episode.show_name | capitalize }}: {{ episode.title | xml_escape }}</a>       
      </li>
    {% endfor %}
  </ul>

  <h2>Unbeaten List</h2>
  
  <ul class="post-list">
    {% assign unbeaten-episodes = site.episodes | where: "category", "unbeaten" | sort: "date" | reverse %}
    {% for episode in unbeaten-episodes %}
      <li>
        <span class="post-meta">{{ episode.date | date_to_string }}</span>
        <a class="post-link" href="{{ episode.url | prepend: site.baseurl }}">{{ episode.show_name | capitalize }}: {{ episode.title | xml_escape }}</a>       
      </li>
    {% endfor %}
  </ul>
</div>