json.extract! message, :id, :published_at, :sender, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
