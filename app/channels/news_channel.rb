class NewsChannel < ApplicationCable::Channel

  def subscribed
    # stream_from "some_channel"
    stream_for 'news_channel'
    ActionCable.server.broadcast 'news_channel', '---------------Test---------------'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
