# frozen_string_literal: true

FactoryBot.define do
  factory :battle do
    association :monsterA, factory: :monster
    association :monsterB, factory: :monster
    association :winner, factory: :monster
  end
end
