ThinkingSphinx::Index.define :book, :with => :active_record do
  # fields
  indexes title
  indexes authors.name
  #indexes title, as: :title, sortable: true
  #indexes author.name, :as => :author, :sortable => true

  # attributes
  has created_at, updated_at
end
