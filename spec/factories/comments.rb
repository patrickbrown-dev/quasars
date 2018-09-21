FactoryBot.define do
  factory :comment do
    body { 'This is the comment body.' }
    article
    user
    karma { 1 }
  end
end
