FactoryGirl.define do
  factory :note do
    title Faker::Book.title
    content Faker::Lorem.sentence

    factory :note_with_empty_title do
      title ''
    end
  end
end
