json.messages @messages do |message|
  json.(message.user, :name)
  json.(message, :content, :created_at)
end
