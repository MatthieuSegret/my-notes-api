FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.sentence
    association :note, factory: :note

    factory :invalid_comment do
      body ''
    end
  end
end
