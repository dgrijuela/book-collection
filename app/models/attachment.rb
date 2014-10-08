class Attachment < ActiveRecord::Base
  belongs_to :book

  # Paperclip gem methods for the file upload
  has_attached_file :file
  validates_attachment :file,
                       presence: true,
                       content_type: { content_type: ["application/pdf",
                                                      "application/epub",
                                                      "application/mobi",
                                                      "application/zip"] }
end
