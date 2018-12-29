class ArticlePresenter < ApplicationPresenter
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
           :is_sticky,
           to: :model

  def title
    if @model.is_sticky
      'Sticky: ' + @model.title
    else
      @model.title
    end
  end

  def user
    @model.user.presenter
  end

  def host
    uri = URI.parse(@model.url)
    uri.host
  end

  def description_only?
    @model.url.empty?
  end
end
