json.set! :cards do
  json.array! @cards, :id, :mechanics, :collectible, :elite, :attack, :cost, :durability, :health, :artist, :faction, :flavor, :how_to_get, :how_to_get_gold, :name, :player_class, :race, :rarity, :set, :text, :card_type, :version
end