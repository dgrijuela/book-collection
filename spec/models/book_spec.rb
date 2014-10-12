require 'rails_helper'

describe Book do
  it 'is valid with a title and a cover' do # add user_id
    expect(FactoryGirl.create(:book)).to be_valid
  end
  it 'is invalid without a title' do
    expect(FactoryGirl.build(:book, title: '')).to be_invalid
  end
  it 'is invalid without a cover' do
    expect(FactoryGirl.build(:book, cover_file_name: '')).to be_invalid
  end
  it 'is invalid without a user_id' # pending
  it "is invalid with a cover_content_type different than images' types" do
    expect(FactoryGirl.build(:book, cover_content_type: 'application/pdf')).to be_invalid
  end
end
