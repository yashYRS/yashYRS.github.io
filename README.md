# yashsarrof.com

This repository contains the static files for [yashsarrof.com](https://yashsarrof.com).
The deployed branch is `gh-pages`.

The current branch stores rendered HTML directly rather than the original Jekyll source files. Most updates are made by editing the generated pages such as `index.html`, `news/index.html`, `resume/index.html`, and `publications/index.html`.

## Test Local Changes

From the repository root:

```bash
cd /Users/yash/Desktop/Personal_Github_repos/yashYRS.github.io
python3 -m http.server 8000
```

Then open:

- Home: <http://localhost:8000/>
- News: <http://localhost:8000/news/>
- CV: <http://localhost:8000/resume/>
- Publications: <http://localhost:8000/publications/>
- Blog: <http://localhost:8000/blog/>

If port `8000` is busy, use another port:

```bash
python3 -m http.server 8080
```

Stop the server with `Ctrl-C`.

## Push Changes to Deploy

GitHub Pages deploys this site from the `gh-pages` branch. To publish changes:

```bash
cd /Users/yash/Desktop/Personal_Github_repos/yashYRS.github.io
git status --short --branch
git diff
git add index.html page2/index.html news/index.html resume/index.html publications/index.html README.md
git commit -m "Update academic website content"
git push origin gh-pages
```

Only stage files that are part of the website update. Leave unrelated local files such as `.DS_Store`, drafts, build caches, or temporary LaTeX outputs unstaged.

After pushing, GitHub Pages usually updates within a minute or two. If the live site looks stale, hard-refresh the browser or wait briefly for the CDN cache to update.

## Update Home Page and News

The home page appears in two paginated copies:

- `index.html`
- `page2/index.html`

The full news page is:

- `news/index.html`

When adding a news item, update both the compact home news list and `news/index.html`. Keep the newest item at the top and use the existing date format, for example:

```html
<li class="news-item">
  <span class="news-date">09/2026:</span>
  News text with <a href="https://example.com/">links</a>.
</li>
```

## Update CV

The CV page is:

- `resume/index.html`

Common sections include:

- Education
- Publications
- Teaching
- Invited Talks and Presentations
- Workshops and Summer Schools
- Honors and Awards
- Academic Service and Organization
- Industry Experience
- Technical Skills

For CV edits, search for the section heading in `resume/index.html`, edit the relevant list item, then test at <http://localhost:8000/resume/>.

## Update Publications

The publications page is:

- `publications/index.html`

To add or edit a publication, search for the publication title or the surrounding year/venue, then follow the existing HTML structure for titles, author lists, venue labels, and links.

Also consider whether the same publication should be reflected in:

- `resume/index.html`
- `index.html` or `news/index.html`, if it is recent news

## Add Blog Posts

Published blog posts live under:

- `posts/<PostSlug>/index.html`

The blog listing is:

- `blog/index.html`

The posts index is:

- `posts/index.html`

Because this branch does not contain the original Markdown/Jekyll source, adding a blog post directly means creating the rendered HTML page and updating the relevant listing pages manually. The safest approach is to copy an existing post folder, replace its page content and metadata, then update:

- `blog/index.html`
- `posts/index.html`
- `feed.xml`
- `sitemap.xml`
- tag pages under `tags/`, if the post has tags

If the original Jekyll source branch is available, prefer adding the Markdown post there and rebuilding the static site instead of hand-editing all generated files.

## Keep Generated Copies in Sync

This branch also contains an ignored `_site/` directory. It is useful for local build output, but Git does not track it because `_site` is ignored.

For tracked deployment changes, the important files are the root-level static pages, for example `index.html`, `news/index.html`, `resume/index.html`, and `publications/index.html`.
