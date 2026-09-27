#!/usr/bin/env bash
#
# Build the whole narmaku.com site into `_site/`:
#   /       personal site (Jekyll, sources in `landing/`)
#   /blog/  blog (Jekyll + Chirpy theme, sources in the repository root)
#
# Used by both Cloudflare Workers Builds and the GitHub Pages workflow.
#
# Usage: tools/build.sh [destination]   (default: _site)

set -euo pipefail

cd "$(dirname "$0")/.."

dest="${1:-_site}"
export JEKYLL_ENV="${JEKYLL_ENV:-production}"
export LANG="${LANG:-C.UTF-8}"

bundle check >/dev/null || bundle install

# The personal site first: it cleans the destination (keeping `blog/`).
bundle exec jekyll build --source landing --destination "$dest"
bundle exec jekyll build --destination "$dest/blog"
