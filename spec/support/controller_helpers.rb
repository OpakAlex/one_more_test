module ControllerHelpers
  extend ActiveSupport::Concern

  def authorize_user(user)
    @request.headers['X-User-Email'] = user.email
    @request.headers['X-User-Token'] = user.authentication_token
  end

  def unauthorize_user
    @request.headers['X-User-Email'] = ''
    @request.headers['X-User-Token'] = ''
  end
end
