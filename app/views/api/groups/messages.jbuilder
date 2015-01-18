json.messages @messages do |message|
  json.(message.user, :name)
  json.(message, :content, :created_at)
end

json.last_get_message_time @last_get_message_time
