class CrimeController < ApplicationController
  include CrimeHelper

  def crime
    # Send coordinates to crime_helper to retrieve crime data from the data police API
    coordinates = request.query_parameters['poly']
    render json: crime_helper(coordinates)
  end

  def autocomplete
    # Fetches auto complete suggestions from cache
    suggestion = Rails.cache.fetch(params[:q], expires_in: 2.days) do
      # If suggestion is not in cache, get the suggestions from the API and store them for 2 days
      JSON.parse(RestClient.get("https://autocomplete.search.hereapi.com/v1/autocomplete?q=#{params[:q]}&apiKey=" + ENV['HERE_API_KEY']))
    end
    render json: suggestion
  end

  def forward
    # Retrieves the coordinates of a provided location from cache
    lat_longs = Rails.cache.fetch('geocode:' + params[:q], expires_in: 7.days) do
      # If the coordinates are not in cache, get the coords from the API and store them for 7 days
      array = JSON.parse(RestClient.get("https://api.mapbox.com/geocoding/v5/mapbox.places/#{CGI.escape(params[:q])}.json?access_token=" + ENV['GEOCODE_API_KEY']))['features']
      # If the place does not exist, return an error
      array.empty? ? { error: 'Place not found' } : array
    end
    render json: lat_longs
  end

end
