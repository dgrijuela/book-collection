require 'faker'

FactoryGirl.define do
  factory :book_author_relation do
    book_id { Faker::Number.digit }
    author_id { Faker::Number.digit }
  end
end
