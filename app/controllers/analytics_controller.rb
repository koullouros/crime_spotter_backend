
class AnalyticsController < ApplicationController
  include CrimeHelper
  include AnalyticsHelper

  def analytics
    location = params[:city].downcase
    location_record = Location.where(name: location)

    if location_record.blank? || (location_record.first.updated < Date.parse(get_latest_crime_date))
      update_database(location)
    end
    location_record = Location.where(name: location)
    crime_entries = CrimeEntry.where(location: location_record.first)
    render json: crime_entries
  end

  def update_database(location)
    # update database for a given location

    location_record = Location.where(name: location)

    if location_record.blank?
      # if the location is not currently in the database, add it
      location_record = Location.create([name: location, updated: Date.parse(get_latest_crime_date)])
    end

    location_record = location_record.first

    location_record.update({ updated: Date.parse(get_latest_crime_date) })

    # fetch the analytics for that location
    # ! WE NEED TO GET MORE THAN ONE MONTH
    crime_stats = get_analytics(location, get_latest_crime_date[0..6])

    crime_stats.each do |key, value|
      crime_entry = CrimeEntry.where(location: location_record, name: key)

      if crime_entry.blank?
        # if it doesn't exist, add it
        crime_entry = CrimeEntry.create([location: location_record, name: key, month: Date.parse(get_latest_crime_date)])
      end
      crime_entry = crime_entry.first

      # to integer conversion changes null to 0
      crime_entry.update({ value: value.to_i, month: Date.parse(get_latest_crime_date) })
      crime_entry.save
    end

  end

end
