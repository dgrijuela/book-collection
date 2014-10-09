require 'rails_helper'

describe Book do
  it 'is valid with a title, a cover, and a user_id'
  it 'is invalid without a title'
  it 'is invalid without a cover'
  it 'is invalid without a user_id'
  it "is invalid with a cover_content_type different than images' types"
end
