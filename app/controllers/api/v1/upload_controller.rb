class Api::V1::UploadController < ApplicationController
  
  class UploadParams
    def self.build(params)
      params.require(:file)
    end
  end
  
  def upload
    file_contents = contents_of_file(UploadParams.build(params))
    begin
      parsed_json = JSON.parse file_contents
    rescue
      return head :unprocessable_entity
    end
    cards = []
    parsed_json.each do |card_hash|
      card = Card.build_or_update_card_with_hash(card_hash)
      if card.nil?
        return head :unprocessable_entity
      else
        cards << card
      end
    end
    cards.each do |card|
      card.save
    end
    head :ok
  end
  
  private
  def contents_of_file(file)
    contents = nil
    if file.respond_to? :read
      contents = file.read
    else
      logger.error "Bad file_data: #{file.class.name}: #{file.inspect}"
    end
    contents
  end
end
