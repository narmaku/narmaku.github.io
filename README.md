# narmaku.com

Personal site of Nicolas Munoz (narmaku): a landing page with about, projects
and services, plus the blog.

| Path     | What                          | Sources                        |
| -------- | ----------------------------- | ------------------------------ |
| `/`      | Personal site                 | `landing/` (plain Jekyll)      |
| `/blog/` | Blog ([Chirpy][chirpy] theme) | repository root (`_posts/`, …) |

Both are built into `_site/` by `tools/build.sh` and published to:

- **https://narmaku.com**: Cloudflare Workers (static assets), deployed by
  Workers Builds on every push to `main`. Configuration: `wrangler.jsonc`.
- **https://narmaku.github.io**: GitHub Pages mirror, deployed by
  `.github/workflows/pages-deploy.yml`. Canonical URLs point to narmaku.com.

## Editing content

- Blog posts: `tools/new_post.sh "Title"` creates a file in `_posts/`.
- Projects: `landing/_data/projects.yml` (`featured: true` shows it on the home page).
- Services: `landing/_data/services.yml`.
- About page: `landing/about.md`. Navigation and links: `landing/_config.yml`.
- Old root-level blog URLs (`/posts/...`) redirect to `/blog/...` via
  `landing/_redirects` (Cloudflare) and `landing/404.html` (GitHub Pages).

## Local development

```shell
bundle install
tools/build.sh                     # full site into _site/
npx serve _site                    # or any static server

tools/run.sh                       # blog only, live reload (http://127.0.0.1:4000/blog/)
bundle exec jekyll serve -s landing -d _site --port 4001   # personal site only
```

## Cloudflare setup (one time)

1. Add `narmaku.com` to Cloudflare (Websites → Add a domain) and switch the
   registrar's nameservers to Cloudflare's.
2. Workers & Pages → Create → Import a repository → `narmaku/narmaku.github.io`.
   - Build command: `tools/build.sh`
   - Deploy command: `npx wrangler deploy` (default)
   - Production branch: `main`
3. The `routes` in `wrangler.jsonc` attach `narmaku.com` as a custom domain on
   the first deploy. For `www`, add a Redirect Rule (Rules → Redirect Rules →
   "Redirect from WWW to root").

[chirpy]: https://github.com/cotes2020/jekyll-theme-chirpy
