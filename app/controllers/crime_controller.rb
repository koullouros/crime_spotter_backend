class CrimeController < ApplicationController
  include CrimeHelper

  def crime
    coordinates = request.query_parameters['poly']
    date = request.query_parameters['date']

    render json: crime_helper(coordinates, date)
  end

  def autocomplete
    suggestion = Rails.cache.fetch(params[:q], expires_in: 2.days) {
      JSON.parse(RestClient.get("https://autocomplete.search.hereapi.com/v1/autocomplete?q=#{params[:q]}&apiKey=" + ENV["HERE_API_KEY"]))
    }
    render json: suggestion
  end

end
