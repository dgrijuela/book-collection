require 'rails_helper'

describe BookAuthorRelation do
  it 'is valid with a book_id and an author_id' do
    expect(FactoryGirl.build(:book_author_relation)).to be_valid
  end
  it 'is invalid without a book_id' do
    expect(FactoryGirl.build(:book_author_relation, book_id: nil)).to be_invalid
  end
  it 'is invalid without an author_id' do
    expect(FactoryGirl.build(:book_author_relation, author_id: nil)).to be_invalid
  end
  it 'is invalid two equal relations' do
    BookAuthorRelation.create(book_id: 3, author_id: 4)
    expect(BookAuthorRelation.new(book_id: 3, author_id: 4)).to be_invalid
  end
end
