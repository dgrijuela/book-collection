class Book < ActiveRecord::Base
  belongs_to :user

  paginates_per 10

  # Paperclip gem methods for the cover image upload
  has_attached_file :cover,
                    styles: {
                      grid: '200x150', # Image size to use in grids (e.g. home page)
                      show: '500x400'
                    }
  validates_attachment :cover,
                       presence: true,
                       content_type: { content_type: /^image\/(jpeg|png|gif|tiff)$/ }

  # BookAuthorRelation table specifies relations between the Book table & the Author table
  has_many :book_author_relations, dependent: :destroy
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


  def self.to_csv
    CSV.generate do |csv|
      csv << ["Books"]
      csv << ["Title", "Authors", "Formats available", "Date of creation"]
      all.each do |book|
        authors_names = book.authors.pluck(:name).map(&:inspect).join(', ').tr('"', '')
        attachments_types = book.attachments.pluck(:file_content_type).map(&:inspect).join(', ').tr('"', '')
        date = book.created_at.strftime("%d/%m, %I:%M")
        csv << [book.title, authors_names, attachments_types, date]
      end
    end
  end
end
