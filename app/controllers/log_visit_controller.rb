class LogVisitController < ApplicationController
  def log_visit
    last_visit = Visit.where(ip_address: params[:ip]).sort_by(&:created_at)
    if last_visit.empty? or ((last_visit.first["created_at"] - Time.now.beginning_of_day).to_i / (24 * 60 * 60)) > 0
      Visit.create(ip_address: params[:ip])
    end
  end

  def get_visit_count
    count = Rails.cache.fetch("internal:visit_count", expires_in: 15.minutes) do
      Visit.where(created_at: Time.current.all_day).count
    end
    render json: count
  end
end
