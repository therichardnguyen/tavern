class Api::V1::UploadController < ApplicationController
  def upload
    file_contents = contents_of_file(params[:file])
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
  def upload_params
    params.require(:file)
  end
  
  def contents_of_file(file)
    contents = nil
    if file.respond_to? :read
      contents = file.read
    elsif file.respond_to? :path
      contents = File.read(file.path)
    else
      logger.error "Bad file_data: #{file.class.name}: #{file.inspect}"
    end
    contents
  end
end
