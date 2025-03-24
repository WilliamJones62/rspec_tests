# frozen_string_literal: true

FactoryBot.define do
  factory :monster do
    name { 'My monster Test' }
    attack { 20 }
    defense { 40 }
    hp { 70 }
    speed { 10 }
    imageUrl { 'https://example.com/image.jpg' }
  end
end
