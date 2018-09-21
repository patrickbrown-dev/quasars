FactoryBot.define do
  factory :article do
    sequence(:url) { |e| "https://xkcd.com/#{e}/" }
    sequence(:title) { |e| "Hertzsprung-Russell Diagram #{e}" }
    description { 'The Hertzsprung-Russell diagram' }
    user
    karma { 1 }
  end
end
