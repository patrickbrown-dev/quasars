class ArticlePresenter < ApplicationPresenter
  attr_reader :article

  delegate :upvoted_by_user?,
           :id,
           :karma,
           :title,
           :uid,
           :slug,
           :description,
           :host,
           :comments,
           :url,
           to: :article

  def initialize(article)
    @article = article
  end

  def user
    @article.user.presenter
  end

  def host
    uri = URI.parse(@article.url)
    uri.host
  end

  def description_only?
    @article.url.empty?
  end

  def created_at_in_words
    time_ago_in_words(@article.created_at)
  end
end
