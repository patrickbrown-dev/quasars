json.extract! article, :id, :user_id, :title, :url, :description, :created_at, :updated_at
json.url article_url(article, format: :json)
