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
    "hearthstone_id" => card.hearthstone_id,
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

describe Api::V1::CardsController do
  describe "#index" do
    let!(:cards) {FactoryGirl.create_list(:card,3)}
    skip "an unauthenticated api"
    
    it "assigns all the cards" do
      get :index, format: :json
      expect(assigns :cards).to match_array cards
    end
    
    it "renders a collection of cards" do
      get :index, format: :json
      parsed = JSON.parse response.body
      expected_array = []
      cards.each do |card|
        expected_array << card_hash_builder(card)
      end
      expect(parsed.count).to eq 3
      expect(parsed).to match_array expected_array
    end
  end
end
