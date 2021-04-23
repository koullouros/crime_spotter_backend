class LogVisitController < ApplicationController
  def log_visit
    Visit.create(page: params[:page], ip_address: params[:ip], location: params[:location])
  end

  def get_visits
    pages = Visit.where(page: params[:page])
    render json: pages
  end

  def get_visit_count
    count = Visit.where(page: params[:page]).count
    render :json => count
  end
end
