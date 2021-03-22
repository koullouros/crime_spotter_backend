module ApplicationCable
  class NewsSocketUser
    def initialize
      @uid = (0...32).map { ('a'..'z').to_a[rand(26)] }.join
      @location = ""
      @source = ""
    end

    def set_data(location, source)
      @location = location
      @source = source
    end

    def uid
      @uid
    end
  end

  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      # self.current_user = (0...32).map { ('a'..'z').to_a[rand(26)] }.join
      self.current_user = NewsSocketUser.new
    end

  end
end
