FactoryBot.define do
  factory :vote do
    vote 1
    user
    appraised factory: :question
  end
end
