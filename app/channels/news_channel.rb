
class NewsChannel < ApplicationCable::Channel

  def subscribed
    #stream_for current_user
    for i in 1..50 do
      NewsChannel.broadcast_to current_user.uid, { body: '---------------Test---------------' }
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def initialise_source(data)
    current_user.set_data data["location"], data["source"]

    # data["source"]
    scrape = google_scraper("#{data["location"]} crime")

    puts scrape

    NewsChannel.broadcast_to current_user.uid, scrape
  end
  
end
