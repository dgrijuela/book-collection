class Attachment < ActiveRecord::Base
  belongs_to :book
  #validates_presence_of :book_id

  # Paperclip gem methods for the file upload
  has_attached_file :file
  validates_attachment :file,
                       presence: true,
                       content_type: { content_type: ["binary/octet-stream",
                                                      "application/pdf",
                                                      "application/epub+zip",
                                                      "application/epub",
                                                      "application/mobi",
                                                      "application/x-mobipocket-ebook",
                                                      "application/zip"] }
end
