
class NewsChannel < ApplicationCable::Channel
  include ScraperHelper

  def subscribed
    stream_for current_user

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def request_update(data)
    scrape = nil
    case data["source"]
    when "google"
      scrape = google_scraper("#{data["location"]}, UK crime")
    when "independent", "guardian"
      scrape = cse_scraper("#{data["location"]}, UK crime", data["source"])
    else
      scrape = google_scraper("#{data["location"]}, UK crime")
    end
    NewsChannel.broadcast_to current_user, scrape
  end
end
