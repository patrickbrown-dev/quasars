FactoryBot.define do
  factory :article do
    url "https://xkcd.com/2009/"
    title "Hertzsprung-Russell Diagram"
    description "The Hertzsprung-Russell diagram is located in its own lower right corner, unless you're viewing it on an unusually big screen."
    user
    karma 1
  end
end
