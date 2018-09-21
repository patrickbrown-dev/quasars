FactoryBot.define do
  factory :report do
    user
    association :reportable, factory: :article
    description { 'A report description' }
  end
end
