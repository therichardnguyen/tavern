class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
  protect_from_forgery
  respond_to :json
end
