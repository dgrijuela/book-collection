class Book < ActiveRecord::Base
  belongs_to :user

  # Paperclip gem methods for the cover image upload
  has_attached_file :cover,
                    styles: {
                      grid: '200x150' # Image size to use in grids (e.g. home page)
                    }
  validates_attachment :cover,
                       presence: true,
                       content_type: { content_type: /^image\/(jpeg|png|gif|tiff)$/ }

  # BookAuthorRelation table specifies relations between the Book table & the Author table
  has_many :book_author_relations
  accepts_nested_attributes_for :book_author_relations

  has_many :authors, through: :book_author_relations

  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments

  validates :title, presence: true
  validates :user_id, presence: true
end
