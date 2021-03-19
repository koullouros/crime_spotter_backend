module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = (0...32).map { ('a'..'z').to_a[rand(26)] }.join
    end

  end
end
