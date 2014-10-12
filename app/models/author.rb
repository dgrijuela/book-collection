class Author < ActiveRecord::Base
  before_save :titleize_name

  has_many :book_author_relations
  validates :name, presence: true

  def titleize_name
    self.name = self.name.titleize
  end
end
