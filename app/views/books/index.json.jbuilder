json.array!(@books) do |book|
  json.extract! book, :id, :title, :user_id
  json.url book_url(book, format: :json)
end
