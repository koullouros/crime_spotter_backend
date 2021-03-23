
class NewsChannel < ApplicationCable::Channel

  def subscribed
    stream_for current_user
    for i in 1..50 do
      NewsChannel.broadcast_to current_user, { body: '---------------Test---------------' }
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def request_update(data)
    scrape = google_scraper("#{data["location"]} crime")
    NewsChannel.broadcast_to current_user, scrape
  end
end
