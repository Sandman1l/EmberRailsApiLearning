# frozen_string_literal: true

# spec/factories/items.rb
FactoryBot.define do
  factory :author do
    name { Faker::Name.name }
  end
end
