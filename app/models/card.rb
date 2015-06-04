class Card < ActiveRecord::Base
  self.primary_key = 'hearthstone_id'
  validates :name, presence: true
  validates :card_type, presence: true
end
