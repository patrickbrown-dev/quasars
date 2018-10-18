module ArticlesHelper
  def article_path_with_slug(uid, slug)
    "#{article_path(uid)}/#{slug}"
  end
end
