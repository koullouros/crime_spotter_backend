class LogSearchController < ApplicationController

  def get_search_count
    # Retrieves the search count from the database
    count = Rails.cache.fetch('internal:search_count', expires_in: 15.minutes) do
      Search.all.count
    end
    render json: { count: count }
  end
end
