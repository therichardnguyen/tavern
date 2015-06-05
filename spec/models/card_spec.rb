require 'spec_helper'

describe Card do
  let(:card) { FactoryGirl.create(:card) }
  describe ":id" do
    it { expect(card.id).to eq(card.hearthstone_id) } 
  end
  
  describe ":mechanics" do
    it {expect(card.mechanics).to be_an Array}
  end
  describe "validations" do
    it "should require a :name" do
      expect(FactoryGirl.build(:card, name: "")).to_not be_valid
    end
    it 'should require a :card_type' do
      expect(FactoryGirl.build(:card, card_type: "")).to_not be_valid
    end
  end
end