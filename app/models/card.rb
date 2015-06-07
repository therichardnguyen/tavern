class Card < ActiveRecord::Base
  self.primary_key = 'hearthstone_id'
  serialize :mechanics, Array
  validates :name, presence: true
  validates :card_type, presence: true
  validates :version, presence: true
  
  def self.build_or_update_card_with_hash(hash, version="UNKNOWN")
    attributes = {"version" => version}
    hash.each do |key,value|
      attributes[self.processed_key(key)] = value
    end
    begin
      existing_card = Card.find(attributes["hearthstone_id"])
      existing_card.assign_attributes(attributes)
      return existing_card
    rescue
      begin
        return Card.new(attributes)
      rescue
        return nil
      end
    end
  end
  
  def self.processed_key(key)
    processed_key = key.underscore
    if (processed_key == "type")
      processed_key = "card_type"
    elsif (processed_key == "id")
      processed_key = "hearthstone_id"
    end
    processed_key
  end
end
