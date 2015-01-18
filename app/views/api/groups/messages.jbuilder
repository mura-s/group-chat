json.messages @messages do |message|
  json.(message.user, :name)
  json.(message, :content, :created_at)
end

json.last_message_id @last_message_id
