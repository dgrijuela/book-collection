require 'rails_helper'

describe Book do
  before(:each) do
    @book = Book.new(title: "The Test Book",
                     user_id: 6,
                     cover_file_name: "thetestcover.png",
                     cover_content_type: "image/png",
                     cover_file_size: 1024,
                     authors_attributes: [name: "john"],
                     attachments_attributes: [file_file_name: "thetestattachment.pdf",
                                              file_content_type: "application/pdf",
                                              file_file_size: 1024])
  end

  it 'is valid with a title, a cover, and an user_id' do
    expect(@book).to be_valid
  end
  it 'is invalid without a title' do
    @book.title = ''
    expect(@book).to be_invalid
  end
  it 'is invalid without a cover' do
    @book.cover_file_name = ''
    expect(@book).to be_invalid
  end
  it 'is invalid without a user_id' do
    @book.user_id = nil
    expect(@book).to be_invalid
  end
  it "is invalid with a cover_content_type different than images' types" do
    @book.cover_content_type = "application/pdf"
    expect(@book).to be_invalid
  end
  it "should be able to create authors" do
    @book.save
    expect(@book.authors.pluck(:name)).to eq(["John"])
  end
  it "should be able to create attachments" do
    @book.save
    expect(@book.attachments.pluck(:file_file_name)).to eq(["thetestattachment.pdf"])
  end
end
