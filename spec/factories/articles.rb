# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Color.hex_color }
    body { Faker::HitchhikersGuideToTheGalaxy.quote }
    avatar { Faker::Avatar.image }
  end
end
