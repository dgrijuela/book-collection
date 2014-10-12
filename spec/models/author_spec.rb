require 'rails_helper'

describe Author do
  before(:each) do
    @author = Author.new(name: "john foo")
  end

  it 'is invalid without a name' do
    @author.name = ''
    expect(@author).to be_invalid
  end
  it 'has to have the name titleized' do
    @author.save
    expect(@author.name).to eq("John Foo")
  end
end
