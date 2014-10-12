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
  accepts_nested_attributes_for :book_author_relations,
                                reject_if: :all_blank,
                                allow_destroy: true

  has_many :authors, through: :book_author_relations
  accepts_nested_attributes_for :authors,
                                reject_if: :all_blank,
                                allow_destroy: true

  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates_presence_of :title
  validates_presence_of :user_id
  validates_presence_of :attachments
  validates_presence_of :authors
end
