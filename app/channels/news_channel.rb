class NewsChannel < ApplicationCable::Channel

  def subscribed
    stream_for "news_channel_#{current_user}"
    for i in 1..50 do
      NewsChannel.broadcast_to "news_channel_#{current_user}", { body: '---------------Test---------------' }
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def initialise_source(data)
    puts data
    puts current_user

    scrape = google_scraper("#{data["location"]} crime")

    puts scrape

    NewsChannel.broadcast_to current_user, scrape
  end
  
end
