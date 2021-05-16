class LogVisitController < ApplicationController

  def log_visit
    # Creates a visit entry when a user visits the given page
    Visit.create
  end

  # Get daily visit count
  def get_visit_count
    # Retrieve visit count from cache
    count = Rails.cache.fetch('internal:visit_count', expires_in: 15.minutes) do
      # If no count exists, retrived count from database and cache it for 15 minutes
      Visit.where(created_at: Time.current.all_day).count
    end
    render json: { count: count }
  end
end
