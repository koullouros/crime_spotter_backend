class LogSearchController < ApplicationController
  def log_search
    Search.create(term: params[:search_term])
  end

  def get_search_term_count
    count = Search.where(term: params[:search_term]).count
    render :json => count
  end
end
