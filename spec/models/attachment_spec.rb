require 'rails_helper'

describe Attachment do
  it 'is valid with a file and a book_id'
  it 'is invalid without a file'
  it 'is invalid without a book_id'
  it 'is invalid with a file_content_type different than [pdf, mobi, epub, zip]'
end
