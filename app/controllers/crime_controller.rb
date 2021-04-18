class CrimeController < ApplicationController
  include CrimeHelper

  def crime
    coordinates = request.query_parameters['poly']
    date = request.query_parameters['date']

    render json: crime_helper(coordinates, date)
  end

  def autocomplete
    suggestion = RestClient.get("https://autocomplete.search.hereapi.com/v1/autocomplete?q=#{params[:q]}&apiKey=" + ENV["HERE_API_KEY"])
    # Maybe cache suggestion, but we don't use REDIS so idk how
    render json: JSON.parse(suggestion)
  end

end
