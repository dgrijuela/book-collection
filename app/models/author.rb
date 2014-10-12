class Author < ActiveRecord::Base
  before_save :titleize_name

  has_many :book_author_relations
  has_many :books, through: :book_author_relations

  validates_presence_of :name

  def titleize_name
    self.name = self.name.titleize
  end
end
