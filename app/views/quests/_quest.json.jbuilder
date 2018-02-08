json.extract! quest, :id, :name, :body, :qtype, :created_at, :updated_at
json.url quest_url(quest, format: :json)
