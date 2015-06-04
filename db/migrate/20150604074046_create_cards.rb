class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :mechanics, array: true, default: []
      t.boolean :collectible, default: false
      t.boolean :elite, default: false
      t.integer :attack, default: 0
      t.integer :cost, default: 0
      t.integer :durability, default: 0
      t.integer :health, default: 0
      t.string :artist
      t.string :hearthstone_id, null: false
      t.string :faction
      t.string :flavor
      t.string :how_to_get
      t.string :how_to_get_gold
      t.string :name
      t.string :player_class
      t.string :race
      t.string :rarity
      t.string :set
      t.string :text
      t.string :card_type

      t.timestamps
    end
    
    add_index "cards", ["hearthstone_id"], name: "index_cards_on_hearthstone_id", unique: true, using: :btree
    
  end
end
