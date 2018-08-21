class Api::V1::BaseController < ApplicationController
  acts_as_token_authentication_handler_for User
  serialization_scope :current_user
end
