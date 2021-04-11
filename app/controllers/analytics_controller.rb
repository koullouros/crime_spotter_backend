
class AnalyticsController < ApplicationController
  include CrimeHelper
  include AnalyticsHelper

  def analytics
    location = params[:name].downcase
    location_record = Location.where(name: location)

    if location_record.blank? || (location_record.first.updated < Date.parse(get_latest_crime_date))
      Thread.new do
        update_database(location, Date.parse(get_latest_crime_date))
      end
    end

    location_record = Location.where(name: location)
    crime_entries = CrimeEntry.where(location: location_record.first)
    render json: crime_entries
  end

  def update_database(location, date)
    # update database for a given location

    location_record = Location.where(name: location)

    if location_record.blank?
      # if the location is not currently in the database, add it
      location_record = Location.create([name: location, updated: date])
    end

    location_record = location_record.first

    # fetch the analytics for that location

    location_updated = location_record["updated"]
    month_diff = (date.year * 12 + date.month) - (location_updated.year * 12 + location_updated.month)
    month_diff = month_diff == 0 ? 12 : month_diff

    month_diff.times do |i|
      crime_stats = get_analytics(location, (date << i).to_s[0..6])
      crime_stats.each do |key, value|
        CrimeEntry.create([location: location_record, name: key, value: value.to_i, month: date << i])
      end
    end

    location_record.update({ updated: date })

  end

end
