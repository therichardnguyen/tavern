require 'spec_helper'

describe Card do
  let(:card) { FactoryGirl.create(:card) }
  describe ".id" do
    it { expect(card.id).to eq(card.hearthstone_id) } 
  end
  
  describe ".mechanics" do
    it {expect(card.mechanics).to be_an Array}
  end
  describe "validations" do
    it "should require a :name" do
      expect(FactoryGirl.build(:card, name: "")).to_not be_valid
    end
    it 'should require a :card_type' do
      expect(FactoryGirl.build(:card, card_type: "")).to_not be_valid
    end
    it 'should require a :version' do
      expect(FactoryGirl.build(:card, version: "")).to_not be_valid
    end
  end
  describe "#process_key" do
    it "should transform camelCase keys to underscored keys" do
      expect(Card.processed_key("howToGet")).to eq "how_to_get"
    end
    it "should transform 'type' into 'card_type'" do
      expect(Card.processed_key("type")).to eq "card_type"
    end
    it "should transform 'id' into 'hearthstone_id'" do
      expect(Card.processed_key("id")).to eq "hearthstone_id"
    end
    it "should do nothing if key is underscored and not a special case" do
      expect(Card.processed_key("name")).to eq "name"
    end
  end
  describe "#build_or_update_card_with_hash" do
    let(:valid_hash) {
      {
        "hearthstone_id"=>"BRM_033",
        "name"=>"Blackwing Technician",
        "set"=>"Blackrock Mountain",
        "card_type"=>"Minion",
        "faction"=>"Neutral",
        "rarity"=>"Common",
        "cost"=>3,
        "attack"=>2,
        "health"=>4,
        "text"=>"<b>Battlecry=></b> If you're holding a Dragon, gain +1/+1.",
        "flavor"=>"This is who you go to when your Blackwing needs a tune up. Don't go to a cut rate Blackwing tune up shop!",
        "artist"=>"Matt Dixon",
        "collectible"=>true,
        "how_to_get"=>"Unlocked by defeating Baron Geddon in Molten Core.",
        "how_to_get_gold"=>"Can be crafted after defeating Baron Geddon in Molten Core.",
        "mechanics"=>["Battlecry"]
      }
    }
    let(:subset_valid_hash) {
      {
        "hearthstone_id" => valid_hash["hearthstone_id"],
        "name" => valid_hash["name"],
        "card_type" => valid_hash["card_type"],
        "version" => "UNKNOWN"
      }
    }
    let(:invalid_subset_valid_hash) {
      invalid_hash = subset_valid_hash
      invalid_hash["cost"] = 10
      invalid_hash["bad"] = "hash"
      invalid_hash
    }
    let (:invalid_hash) {
      {
        "bad" => "hash"
      }
    }
    
    context "when card from hash is nonexistant" do
      subject { Card.build_or_update_card_with_hash(valid_hash) }
      it { is_expected.to be_a_new Card }
    end
    
    context "when card from hash exists" do
      before { Card.create! subset_valid_hash }
      subject { Card.build_or_update_card_with_hash(valid_hash) }
      it { is_expected.to be_changed }
      it "should return an updated card" do
        expect(subject.cost).to eq 3
      end
    end
    
    context "when hash is invalid" do
      subject { Card.build_or_update_card_with_hash invalid_subset_valid_hash }
      it { is_expected.to be_nil }
    end
    
    context "when an attribute of the hash is invalid (i.e not an attribute of Card)" do
      subject { Card.build_or_update_card_with_hash invalid_hash }
      it { is_expected.to be_nil }
    end
    
    context "when no :version is provided" do
      subject { Card.build_or_update_card_with_hash(valid_hash).version }
      it { is_expected.to eq "UNKNOWN"}
    end
    
    context "when a :version is provided" do
      let(:version) { "2.6.0.8833" }
      subject { Card.build_or_update_card_with_hash(valid_hash,version).version }
      it { is_expected.to eq version }
    end
  end
end