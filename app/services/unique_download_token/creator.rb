module UniqueDownloadToken
  class Creator
    def self.call(user_id, trailer_ids)
      new(user_id, trailer_ids).call
    end

    def call
      return fetch_user_trailer_tokens unless should_generate?
      generate_trailer_tokens
      store_in_redis
      fetch_user_trailer_tokens
    end

    private

    attr_reader :user_id, :tokens, :trailer_ids

    def initialize(user_id, trailer_ids)
      @user_id     = user_id
      @trailer_ids = trailer_ids
    end

    def store_in_redis
      Redis.current.set(user_key_redis, tokens)
    end

    def should_generate?
      fetch_user_trailer_tokens.blank? || total_count_changed?
    end

    def total_count_changed?
      fetch_user_trailer_tokens.size != Trailer.all.size
    end

    def fetch_user_trailer_tokens
      trailers = Redis.current.get(user_key_redis)
      return {} if trailers.blank?
      JSON.parse trailers
    end

    def generate_trailer_tokens
      @tokens = Trailer.find(trailer_ids).map { |t| [t.id, SecureRandom.hex(9)] }.to_h.to_json
    end

    def user_key_redis
      "user_#{user_id}"
    end
  end
end
