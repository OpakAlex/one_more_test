module Api
  module V1
    class TrailerSerializer < ActiveModel::Serializer
      attributes :name, :link

      def link
        token = JSON.parse(Redis.current.get("user_#{scope.id}")).fetch(object.id.to_s)
        "http://#{Rails.application.routes.default_url_options[:host]}" \
        "/api/v1/trailers/#{object.id}/download?token=#{token}"
      end
    end
  end
end
