class LogSearchController < ApplicationController
  def log_search
    Search.create(term: params[:search_term])
  end

  def get_search_count
    count = Rails.cache.fetch("internal:search_count", expires_in: 15.minutes) do
      Search.all.count
    end
    render json: { count: count }
  end
end
