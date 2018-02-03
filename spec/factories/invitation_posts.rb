# frozen_string_literal: true

FactoryBot.define do
  factory :invitation_post do
    name { Faker::Hacker.abbreviation }
    info { Faker::Hacker.say_something_smart }
    date { Faker::Date.between(2.days.ago, Time.zone.today) }
  end
end
