FactoryGirl.define do
  factory :note do
    title Faker::Book.title
    content Faker::Lorem.sentence
    association :user, factory: :user

    transient do
      comments_count 2
    end

    after(:create) do |note, evaluator|
      create_list(:comment, evaluator.comments_count, note: note)
    end

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
