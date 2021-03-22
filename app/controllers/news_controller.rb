include ScraperHelper

class NewsController < ApplicationController
  def news

  end

  def create
    data = google_scraper('test')

    render json: data
  end

end
