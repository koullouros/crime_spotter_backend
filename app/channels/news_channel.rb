
class NewsChannel < ApplicationCable::Channel
  include ScraperHelper


  def subscribed
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def request_update(data)
    scrape = google_scraper("#{data["location"]} crime")
    
    NewsChannel.broadcast_to current_user, scrape
  end
end
