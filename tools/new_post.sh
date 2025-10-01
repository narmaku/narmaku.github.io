#!/usr/bin/env bash

# Usage: ./new_post.sh "Your Blog Title"

default_author="narmaku"

if [ -z "$1" ]; then
  echo "Usage: $0 \"Blog Title\""
  exit 1
fi

# Format title for filename: lowercase, spaces to dashes, remove non-alphanum except dashes
title_slug=$(echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[^a-z0-9-]//g')

# Get current date
post_date=$(date +'%Y-%m-%d %H:%M:%S %z')
date_prefix=$(date +'%Y-%m-%d')

# Set filename
filename="_posts/${date_prefix}-${title_slug}.md"

# Create the file with front matter and header
cat >"$filename" <<EOF
---
title: $1
author: "$default_author"
date: $post_date
categories: [Category]
tags: [tag]
---
# If a draft file is provided, append its content; otherwise, add default header
EOF

if [ -n "$2" ] && [ -f "$2" ]; then
  # Append draft content if file exists
  cat "$2" >>"$filename"
else
  # No draft, add default header
  echo -e "\n# $1" >>"$filename"
fi

# $1
EOF

echo "New post created: $filename"
