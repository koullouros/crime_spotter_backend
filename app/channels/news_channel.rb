class NewsChannel < ApplicationCable::Channel

  def subscribed
    # stream_from "some_channel"
    stream_for 'news_stream'
    ActionCable.server.broadcast 'news_stream', '---------------Test---------------'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
