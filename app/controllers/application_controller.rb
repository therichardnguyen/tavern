class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::MimeResponds
  respond_to :json
end
