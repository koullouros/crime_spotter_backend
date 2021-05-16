class LogSearchController < ApplicationController

  # Get total search count
  def get_search_count
    # Retrieve search count from cache
    count = Rails.cache.fetch('internal:search_count', expires_in: 15.minutes) do
      # If no count exists, retrived count from database and cache it for 15 minutes
      Search.all.count
    end
    render json: { count: count }
  end
end
