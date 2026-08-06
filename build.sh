#!/usr/bin/env bash
# Static build: compile SCSS, then assemble deployable files into dist/.
set -euo pipefail

# 1. Compile styles
sass css/styles.scss css/styles.css --style=compressed --no-source-map

# 2. Fresh output dir
rm -rf dist
mkdir -p dist/css dist/js/vendor dist/img

# 3. Root files (html, icons, manifests, SEO)
cp index.html 404.html favicon.ico icon.png tile.png tile-wide.png \
   site.webmanifest browserconfig.xml \
   robots.txt sitemap.xml llms.txt humans.txt dist/

# 4. Styles (compiled + static)
cp css/normalize.css css/main.css css/styles.css dist/css/

# 5. Scripts
cp js/main.js js/plugins.js dist/js/
cp js/vendor/*.js dist/js/vendor/

# 6. Images actually referenced by the page
cp img/photo.webp img/photo.jpg img/photo-m.webp img/photo-m.jpg dist/img/

echo "Built dist/ ($(find dist -type f | wc -l | tr -d ' ') files)"
