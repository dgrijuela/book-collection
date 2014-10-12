require 'rails_helper'

describe BookAuthorRelation do
  before(:each) do
    @book_author_relation = BookAuthorRelation.new(book_id: 6,
                                                   author_id: 4)
  end
  
  it 'is valid with a book_id and an author_id' do
    expect(@book_author_relation).to be_valid
  end
  it 'is invalid without a book_id' do
    @book_author_relation.book_id = nil
    expect(@book_author_relation).to be_invalid
  end
  it 'is invalid without an author_id' do
    @book_author_relation.author_id = nil
    expect(@book_author_relation).to be_invalid
  end
  it 'is invalid two equal relations' do
    @book_author_relation.save
    expect(BookAuthorRelation.new(book_id: 6, author_id: 4)).to be_invalid
  end
end
