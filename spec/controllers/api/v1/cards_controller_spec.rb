require 'spec_helper'

describe Api::V1::CardsController do
  describe "#index" do
    let!(:cards) {FactoryGirl.create_list(:card,3)}
    skip "an unauthenticated api"
    
    it "assigns all the cards" do
      get :index, format: :json
      expect(assigns :cards).to match_array cards
    end
  end
end
