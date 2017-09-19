FactoryGirl.define do
  factory :note do
    title Faker::Book.title
    content Faker::Lorem.sentence

    factory :invalid_note do
      title ''
      content Faker::Lorem.characters(9)
    end
  end
end
