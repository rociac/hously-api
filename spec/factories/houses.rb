FactoryBot.define do
  factory :house do
    name { Faker::Address.street_address }
    description { Faker::Lorem.sentence(word_count: 15) } 
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    association :user
  end
end