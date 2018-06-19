# frozen_string_literal: true

# spec/factories/todos.rb
FactoryBot.define do
  factory :book do
    title { Faker::Lorem.word }
    price { Faker::Number.decimal(5, 2) }
    publisher { Faker::Number.number(10) }
    author { Faker::Number.number(10) }
  end
end
