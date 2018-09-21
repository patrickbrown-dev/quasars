FactoryBot.define do
  factory :user do
    sequence(:email) { |e| "user.name#{e}@email.com" }
    password { 'MyPassword' }
    sequence(:username) { |e| "Username#{e}" }
    moderator { false }

    trait :moderator do
      moderator { true }
    end
  end
end
