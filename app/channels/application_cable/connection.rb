module ApplicationCable
  class NewsSocketUser
    def initialize(location, source)
      @uid = (0...32).map { ('a'..'z').to_a[rand(26)] }.join
      @location = location
      @source = source
    end
  end

  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      # self.current_user = (0...32).map { ('a'..'z').to_a[rand(26)] }.join
      self.current_user = NewsSocketUser.new(data["location"], data["source"])
    end

  end
end
