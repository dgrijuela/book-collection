require 'rails_helper'

describe Attachment do
  before(:each) do
    @attachment = Attachment.new(file_file_name: "thetestattachment.pdf",
                                 file_content_type: "application/pdf",
                                 file_file_size: 1024)
  end

  it 'is valid with a file and a book_id' do
    expect(@attachment).to be_valid
  end
  it 'is invalid without a file' do
    @attachment.file_file_name = ''
    expect(@attachment).to be_invalid
  end
  it 'is invalid with a file_content_type different than [pdf, mobi, epub, zip]' do
    @attachment.file_content_type = 'image/png'
    expect(@attachment).to be_invalid
  end
end
