
class AnalyticsController < ApplicationController
  include CrimeHelper
  include AnalyticsHelper

  def analytics
    # Responsible for returning analytics to front end given a city
    location = params[:name].downcase
    location_name = get_city_poly_name(location)
    location_record = Location.where(name: location_name)

    # if location hasn't been updated recently, update location
    if location_record.blank? || (location_record.first.updated < Date.parse(get_latest_crime_date))
      Thread.new do
        update_database(location, location_name, Date.parse(get_latest_crime_date))
      end
    end

    location_record = Location.where(name: location_name)
    crime_entries = CrimeEntry.where(location: location_record.first)

    render json: crime_entries
  end

  def update_database(location, long_name, date)
    # update database for a given location
    location_record = Location.where(name: long_name)

    if location_record.blank?
      # if the location is not currently in the database, add it
      location_record = Location.create([name: long_name, updated: date])
    end

    location_record = location_record.first

    # fetch the analytics for that location

    location_updated = location_record["updated"]
    month_diff = (date.year * 12 + date.month) - (location_updated.year * 12 + location_updated.month)
    month_diff = month_diff == 0 ? 4 : month_diff

    month_diff.times do |i|
      GC.start
      crime_stats = get_analytics(location, (date << i).to_s[0..6])

      crime_stats.each do |key, value|
        crime_entry = CrimeEntry.where(location: location_record, name: key)

        if crime_entry.blank?
          # if it doesn't exist, add it
          crime_entry = CrimeEntry.create([location: location_record, name: key, value: value.to_i, month: date << i])
        end

        crime_entry = crime_entry.first

        crime_entry.update({ value: value.to_i, month: Date.parse(get_latest_crime_date) })
      end
    end

    location_record.update({ updated: date })

  end

end
