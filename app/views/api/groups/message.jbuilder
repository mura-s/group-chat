json.message do
  json.(@user, :name)
  json.(@message, :content, :created_at)
end
