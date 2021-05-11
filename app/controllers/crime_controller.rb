class CrimeController < ApplicationController
  include CrimeHelper

  def crime
    # Send coordinates to crime_helper to retrieve crime data from the data police API
    coordinates = request.query_parameters['poly']

    render json: crime_helper(coordinates)
  end

  def autocomplete
    # Fetches auto complete suggestions
    suggestion = Rails.cache.fetch(params[:q], expires_in: 2.days) do
      JSON.parse(RestClient.get("https://autocomplete.search.hereapi.com/v1/autocomplete?q=#{params[:q]}&apiKey=" + ENV['HERE_API_KEY']))
    end
    render json: suggestion
  end

  def forward
    # Retrieves the coordinates of a provided location
    lat_longs = Rails.cache.fetch('geocode:' + params[:q], expires_in: 7.days) do
      array = JSON.parse(RestClient.get("https://api.mapbox.com/geocoding/v5/mapbox.places/#{CGI.escape(params[:q])}.json?access_token=" + ENV['GEOCODE_API_KEY']))['features']
      array.empty? ? { error: 'Place not found' } : array
    end
    render json: lat_longs
  end

end
