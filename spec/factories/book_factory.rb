require 'faker'

FactoryGirl.define do
  factory :book do
    title {Faker::Lorem.sentence(3)}
    cover_file_name { Faker::Lorem.word }
    cover_content_type { 'image/png' }
    cover_file_size { 1024 }
  end
end
