require 'rails_helper'

describe Author do
  it 'is invalid without a name' do
    expect(FactoryGirl.build(:author, name: '')).to be_invalid
  end
  it 'has to have the name titleized' do
    @author = Author.create(name: "juan")
    expect(@author.name).to eq("Juan")
  end
end
