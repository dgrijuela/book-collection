require 'rails_helper'

describe Attachment do
  it 'is valid with a file and a book_id' do
    expect(FactoryGirl.build(:attachment)).to be_valid
  end
  it 'is invalid without a file' do
    expect(FactoryGirl.build(:attachment, file_file_name: '')).to be_invalid
  end
  it 'is invalid without a book_id' do
    expect(FactoryGirl.build(:attachment, book_id: nil)).to be_invalid
  end
  it 'is invalid with a file_content_type different than [pdf, mobi, epub, zip]' do
    expect(FactoryGirl.build(:attachment, file_content_type: 'image/png')).to be_invalid
  end
end
