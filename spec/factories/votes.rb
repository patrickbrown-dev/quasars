FactoryBot.define do
  factory :vote do
    user
    association :voteable, factory: :article
  end
end
