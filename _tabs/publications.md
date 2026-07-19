---
# the default layout is 'page'
icon: fas fa-file-lines
order: 3
---

<style>
  ol.bibliography {
    list-style: none;
    margin: 0;
    padding-left: 0;
  }

  ol.bibliography > li {
    margin-bottom: 1rem;
  }

  .publication-card {
    background: var(--main-bg);
    border: 1px solid var(--main-border-color);
    border-radius: 8px;
    box-shadow: 0 0.35rem 1.2rem rgba(0, 0, 0, 0.035);
    padding: 1rem 1.1rem;
  }

  .publication-title {
    font-size: 1.05rem;
    font-weight: 650;
    line-height: 1.35;
    margin: 0;
  }

  .publication-title a {
    color: inherit;
    text-decoration: none;
  }

  .publication-title a:hover {
    color: var(--link-color);
    text-decoration: underline;
  }

  .publication-authors {
    color: var(--text-muted-color);
    line-height: 1.5;
    margin-top: 0.35rem;
  }

  .publication-authors em {
    color: var(--heading-color);
    font-style: normal;
    font-weight: 650;
  }

  .publication-meta {
    align-items: center;
    color: var(--text-muted-color);
    display: flex;
    flex-wrap: wrap;
    font-size: 0.92rem;
    gap: 0.35rem 0.55rem;
    margin-top: 0.55rem;
  }

  .publication-meta span:not(:last-child)::after {
    color: var(--text-muted-color);
    content: "·";
    margin-left: 0.55rem;
  }

  .publication-venue {
    border: 1px solid var(--link-underline-color);
    border-radius: 999px;
    color: var(--link-color);
    font-size: 0.8rem;
    font-weight: 700;
    line-height: 1.5;
    padding: 0.02rem 0.5rem;
  }

  .publication-meta .publication-venue::after {
    content: "";
    margin-left: 0;
  }

  .publication-links {
    display: flex;
    flex-wrap: wrap;
    gap: 0.45rem;
    margin-top: 0.7rem;
  }

  .publication-link {
    background: var(--button-bg);
    border: 1px solid var(--btn-border-color);
    border-radius: 999px;
    color: var(--link-color);
    font-size: 0.82rem;
    line-height: 1.4;
    padding: 0.16rem 0.58rem;
    text-decoration: none;
  }

  .publication-link:hover {
    background: var(--sidebar-hover-bg);
    text-decoration: none;
  }

  .publication-bibtex {
    margin-top: 0.75rem;
  }
</style>

{% bibliography %}
