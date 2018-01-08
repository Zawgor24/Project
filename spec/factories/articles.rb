# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Company.name }
    body { Faker::HitchhikersGuideToTheGalaxy.quote }
  end
end
