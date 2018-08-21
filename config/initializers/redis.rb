Redis.current = Redis::Namespace.new("secure_link_#{Rails.env}", :redis => Redis.new)
