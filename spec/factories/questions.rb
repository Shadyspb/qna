FactoryBot.define do
  factory :question do
    association :user, factory: :user
    sequence(:title) { |n| "Title #{n}" }
    sequence(:body) { |n| "MyText #{n}" }

    factory :invalid_question do
      title nil
      body nil
    end
  end

  factory :question_with_vote, parent: :question do
    after(:create) { |question| create(:vote, appraised: question)}
  end
end
