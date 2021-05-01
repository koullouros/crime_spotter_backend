class CrimeController < ApplicationController
  include CrimeHelper

  def crime
    coordinates = request.query_parameters['poly']

    render json: crime_helper(coordinates)
  end

  def autocomplete
    suggestion = Rails.cache.fetch(params[:q], expires_in: 2.days) do
      JSON.parse(RestClient.get("https://autocomplete.search.hereapi.com/v1/autocomplete?q=#{params[:q]}&apiKey=" + ENV["HERE_API_KEY"]))
    end
    render json: suggestion
  end

  def forward
    lat_longs = Rails.cache.fetch("geocode:" + params[:q], expires_in: 7.days) do
      array = JSON.parse(RestClient.get("http://api.openweathermap.org/geo/1.0/direct?q=#{params[:q]}&limit=5&appid=" + ENV["GEOCODE_API_KEY"]))
      array.empty? ? { error: "Place not found" } : array
    end
    render json: lat_longs
  end

end
