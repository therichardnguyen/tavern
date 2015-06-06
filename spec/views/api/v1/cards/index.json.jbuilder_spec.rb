require 'spec_helper'

def card_hash_builder(card)
  {
    "mechanics" => card.mechanics,
    "collectible" => card.collectible,
    "elite" => card.elite,
    "attack" => card.attack,
    "cost" => card.cost,
    "durability" => card.durability,
    "health" => card.health,
    "artist" => card.artist,
    "id" => card.hearthstone_id,
    "faction" => card.faction,
    "flavor" => card.flavor,
    "how_to_get" => card.how_to_get,
    "how_to_get_gold" => card.how_to_get_gold,
    "name" => card.name,
    "player_class" => card.player_class,
    "race" => card.race,
    "rarity" => card.rarity,
    "set" => card.set,
    "text" => card.text,
    "card_type" => card.card_type,
  }
end

describe "api/v1/cards/index" do
  number_of_cards = 3
  root_count = 1
  let!(:cards) {FactoryGirl.create_list(:card,number_of_cards)}
  
  it "renders a collection of cards" do
    assign(:cards, cards)
    render
    parsed = JSON.parse rendered
    expected_array = []
    cards.each do |card|
      expected_array << card_hash_builder(card)
    end
    expect(parsed.count).to eq root_count
    expect(parsed["cards"].count).to eq number_of_cards
    expect(parsed["cards"]).to match_array expected_array
  end
end