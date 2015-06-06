class Api::V1::CardsController < ApplicationController
  def index
    @cards = Card.all
    respond_with @cards
  end
end
