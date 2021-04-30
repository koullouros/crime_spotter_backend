class LogVisitController < ApplicationController
  def log_visit
    Visit.create
  end

  def get_visit_count
    count = Rails.cache.fetch("internal:visit_count", expires_in: 15.minutes) do
      Visit.where(created_at: Time.current.all_day).count
    end
    render json: count
  end
end
