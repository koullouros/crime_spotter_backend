
class AnalyticsController < ApplicationController
  include CrimeHelper
  include AnalyticsHelper

  def analytics
    # Responsible for returning analytics to front end given a city
    location = params[:name].downcase

    return NoMethodError if location.nil?

    unless is_location_in_uk(location)
      render json: {error: 'Location is invalid'}
      return
    end

    Search.create(term: params[:name])
    location_name = get_city_poly_name(location)
    location_record = Location.where(name: location_name)
    # if location hasn't been updated recently, update location
    if location_record.blank? || (location_record.first.updated < Date.parse(get_latest_crime_date))
      AnalyticsJob.new.analyse(location, location_name, Date.parse(get_latest_crime_date))
    end

    location_record = Location.where(name: location_name)
    crime_entries = CrimeEntry.where(location: location_record.first)

    render json: crime_entries
  end
end
