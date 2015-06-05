FactoryGirl.define do
  factory :card do
    hearthstone_id { "#{Faker::Lorem.word}_#{rand(10..99)}" }
    name { Faker::Lorem.words(rand(1..3)).join(" ") }
    card_type {["Mage","Warrior","Paladin", "Hunter","Rogue","Druid", "Priest","Warlock","Shaman"][rand(9)]}
    cost {rand(20)}
    attack {rand(20)}
    health {rand(20)}
    text Faker::Lorem.sentence
    rarity {["Common", "Rare", "Epic", "Legendary"][rand(4)]}
    version { "#{Faker::Number.digit}.#{Faker::Number.digit}.#{Faker::Number.digit}.#{Faker::Number.number(4)}" }
  end
end