FactoryGirl.define do
  factory :user do
    name Faker::GameOfThrones.character

    transient do
      notes_count 0
    end

    after(:create) do |user, evaluator|
      create_list(:note, evaluator.notes_count, user: user)
    end
  end
end
