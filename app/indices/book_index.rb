ThinkingSphinx::Index.define :book, :with => :active_record do
  # fields
  indexes title
  indexes authors.name
  indexes attachments.file_file_name

  # attributes
  has created_at, updated_at
end
