require 'rails_helper'

RSpec.describe "books/edit", :type => :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :title => "MyString",
      :user_id => "MyString"
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input#book_title[name=?]", "book[title]"

      assert_select "input#book_user_id[name=?]", "book[user_id]"
    end
  end
end
