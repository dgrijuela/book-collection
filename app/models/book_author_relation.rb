class BookAuthorRelation < ActiveRecord::Base
  belongs_to :book
  belongs_to :author

  validates_presence_of :book_id
  validates_presence_of :author_id

  validates_uniqueness_of :author_id, scope: :book_id

  accepts_nested_attributes_for :author,
                                allow_destroy: true
end
