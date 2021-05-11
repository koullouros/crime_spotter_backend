class LogVisitController < ApplicationController

  def log_visit
    # Creates a visit entry when a user visits the given page
    Visit.create
  end

  def get_visit_count
    # Retrieves the visit count from the database
    count = Rails.cache.fetch('internal:visit_count', expires_in: 15.minutes) do
      Visit.where(created_at: Time.current.all_day).count
    end
    render json: { count: count }
  end
end
