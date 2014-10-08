class Author < ActiveRecord::Base
  has_many :book_author_relations

  validates_presence_of :name
end
