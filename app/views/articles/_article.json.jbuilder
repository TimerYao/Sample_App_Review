json.extract! article, :id, :name, :brief_text, :created_at, :updated_at
json.url article_url(article, format: :json)
