FactoryBot.define do
  factory :article do
    url { 'https://xkcd.com/2009/' }
    title { 'Hertzsprung-Russell Diagram' }
    description { 'The Hertzsprung-Russell diagram' }
    user
    karma { 1 }
  end
end
