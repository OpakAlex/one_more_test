module UniqueDownloadToken
  class Validator
    include ActiveModel::Model

    validates :token, :user_id, :trailer_id, presence: true
    validate  :token_digest_valid?

    def initialize(user_id, trailer_id, token)
      @user_id    = user_id.to_s
      @trailer_id = trailer_id.to_s
      @token      = token
    end

    private

    attr_reader :token, :user_id, :trailer_id

    def token_digest_valid?
      tokens = Redis.current.get("user_#{user_id}")
      notify_invalid! if tokens.blank?

      token_in_redis = JSON.parse(tokens).fetch(trailer_id)
      notify_invalid! if token_differs?(token_in_redis)
    end

    def token_differs?(present_in_redis)
      present_in_redis != token
    end

    def notify_invalid!
      errors.add(:base, 'Invalid token given')
      throw(:abort)
    end
  end
end
