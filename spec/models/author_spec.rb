require 'rails_helper'

describe Author do
  it 'is invalid without a name' do
    expect(FactoryGirl.build(:author, name: '')).to be_invalid
  end
  it 'has to have the name titleized'
end
