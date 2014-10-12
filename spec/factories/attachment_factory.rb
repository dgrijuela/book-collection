require 'faker'

FactoryGirl.define do
  factory :attachment do
    file_file_name { Faker::Lorem.word }
    file_content_type { 'application/pdf' }
    file_file_size { 1024 }
    book_id { Faker::Number.digit }
  end
end
