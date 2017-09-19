FactoryGirl.define do
  factory :note do
    title Faker::Book.title
    content Faker::Lorem.sentence

    factory :another_note do
      title 'a note'
      content 'a content with more than 10 characters'
    end

    factory :invalid_note do
      title ''
      content Faker::Lorem.characters(9)
    end
  end
end
