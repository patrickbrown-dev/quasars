require 'rss'

class FeedController < ApplicationController
  def index
    articles = Article.hot.limit(20)
    last_update_at = articles.first.created_at

    rss = RSS::Maker.make('atom') do |maker|
      maker.channel.author = 'feed@quasa.rs'
      maker.channel.updated = last_update_at.to_s
      maker.channel.about = 'a link-aggregator for astrophysics'
      maker.channel.title = 'Quasars'

      articles.each do |article|
        maker.items.new_item do |item|
          item.id = article.uid
          item.link = article_url(article.uid)
          item.title = article.title
          item.updated = article.created_at.to_s
          unless article.description.empty?
            item.description = CommonMarker.render_html(
              article.description,
              :DEFAULT
            )
          end
        end
      end
    end

    render plain: rss, status: :ok
  end
end
