class LogSearchController < ApplicationController

  def get_search_count
    # Retrieves the search count from the database
    count = Rails.cache.fetch('internal:search_count', expires_in: 15.minutes) do
      Search.where(created_at: Time.current.all_day).count
    end
    render json: { count: count }
  end
end
