# frozen_string_literal: true

# Reads the blog's posts (the Chirpy site in the repository root) and exposes
# them as `site.data.blog_posts`, newest first, so the home page can link to
# the latest articles without being part of the blog build.
module Narmaku
  class BlogPostsGenerator < Jekyll::Generator
    safe true
    priority :high

    FILENAME = /\A(?<date>\d{4}-\d{1,2}-\d{1,2})-(?<slug>.+)\.(?:md|markdown)\z/.freeze
    FRONT_MATTER = /\A---\s*\n(?<yaml>.*?)\n---\s*\n(?<body>.*)\z/m.freeze

    def generate(site)
      config = site.config["blog"] || {}
      dir = File.expand_path(config["posts_dir"] || "../_posts", site.source)
      base = config["path"] || "/blog"

      posts = Dir.glob(File.join(dir, "*.{md,markdown}")).filter_map do |file|
        name = FILENAME.match(File.basename(file)) or next
        parts = FRONT_MATTER.match(File.read(file, encoding: "UTF-8")) or next
        data = SafeYAML.load(parts[:yaml]) || {}
        next if data["published"] == false || data["hidden"]

        {
          "title" => data["title"],
          "date" => Jekyll::Utils.parse_date((data["date"] || name[:date]).to_s),
          "url" => "#{base}/posts/#{data["slug"] || name[:slug]}/",
          "categories" => Array(data["categories"]),
          "excerpt" => data["description"] || excerpt(parts[:body])
        }
      end

      site.data["blog_posts"] = posts.sort_by { |post| post["date"] }.reverse
    end

    private

    # First prose paragraph of the post, as plain text.
    def excerpt(body)
      paragraph = body.split(/\n\s*\n/).map(&:strip).find do |block|
        !block.empty? && !block.start_with?("#", "!", ">", "```", "|", "-", "*")
      end
      return unless paragraph

      text = paragraph.gsub(/\[([^\]]*)\]\([^)]*\)/, '\1').gsub(/[*_`]/, "").gsub(/\s+/, " ")
      text.length > 180 ? "#{text[0, 177].sub(/\s+\S*\z/, "")}…" : text
    end
  end
end
