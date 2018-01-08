# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    first_name { Faker::ProgrammingLanguage.name }
    last_name { Faker::Beer.name }
    birthday { Faker::Date.birthday(18, 65) }
    info { Faker::Lorem.sentence(3) }
    address { Faker::Address.city }
    sex { User.sexes.keys.sample }
    avatar { Faker::Avatar.image }
  end
end
