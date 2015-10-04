# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.nooffy.com"
SitemapGenerator::Sitemap.sitemaps_host = "http://www.nooffy.com"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #

    User.find_each do |user|
      user.articles.find_each do |article|
        add user_article_path(user, article), :lastmod => article.updated_at
      end
    end    
  #  Article.find_each do |article|
  #    add article_path(article), :lastmod => article.updated_at
  #  end
end
