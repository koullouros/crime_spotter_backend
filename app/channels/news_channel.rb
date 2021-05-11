
class NewsChannel < ApplicationCable::Channel
  include ScraperHelper

  def subscribed
    # Opens a channel using a unique ID
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def request_update(data)
    # Pushes scraped data through the channel when requested, using the provided scraper
    case data['source']
    when 'independent', 'guardian'
      scrape = cse_scraper("#{data['location']}, crime", data['source'])
    else
      scrape = google_scraper("#{data['location']} crime")
    end
    NewsChannel.broadcast_to current_user, scrape
  end
end
