
FactoryBot.define do
  factory :publishing_house do
    name { Faker::Name.name }
    discount { Faker::Number.decimal(2, 2) }
  end
end
