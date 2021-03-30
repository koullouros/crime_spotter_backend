
class AnalyticsController < ApplicationController
  include AnalyticsHelper

  def analytics
    location = params[:city]
    location_record = Location.where(name: location)

    if location_record.blank? or location_record.first.updated < Date.new(Date.today.year, Date.today.month)
      update_database(location)
    end

    crime_entries = CrimeEntry.where(location: location_record.first)
    render json: crime_entries
  end

  def update_database(location)
    # update database for a given location

    #location = params[:city]
    location_record = Location.where(name: location)


    if location_record.blank?
      # if the location is not currently in the database, add it
      location_record = Location.create([name: location, updated: Date.today])
    end

    location_record = location_record.first

    location_record.update({:updated => Date.today})

    # fetch the analytics for that location
    crime_stats = get_analytics(location)

    crime_stats.each do |key, value|
      crime_entry = CrimeEntry.where(location: location_record, name: key)

      if crime_entry.blank?
        # if it doesn't exist, add it
        crime_entry = CrimeEntry.create([location: location_record, name: key])
      end
      crime_entry = crime_entry.first

      crime_entry.update({:value => value})
      crime_entry.save
    end

  end

end
