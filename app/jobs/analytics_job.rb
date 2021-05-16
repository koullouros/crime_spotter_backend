class AnalyticsJob
    include CrimeHelper
    include AnalyticsHelper
    # Get crime data from a location
    def analyse(location, long_name, date)
      # update database for a given location
      location_record = Location.where(name: long_name)
  
      if location_record.blank?
        # if the location is not currently in the database, add it
        location_record = Location.create([name: long_name, updated: date])
      end
      location_record = location_record.first
      # Sanity check for jobs
      months = CrimeEntry.where(location_id: location_record["id"], month: date)
      if not months.empty?
        return
      end
  
      # fetch the analytics for that location
      location_updated = location_record["updated"]
      month_diff = (date.year * 12 + date.month) - (location_updated.year * 12 + location_updated.month)
      # If there is no month difference, assume we need 6 months of data
      # If there is a difference, get X amount of months with X being difference
      month_diff = month_diff == 0 ? 6 : month_diff
 
      month_diff.times do |i|
        # Start GC to save memory
        GC.start
        # Get crime for each date
        crime_stats = get_analytics(location, (date << i).to_s[0..6])
        crime_stats.each do |key, value|
          CrimeEntry.create([location: location_record, name: key, value: value.to_i, month: date << i])
        end
      end
      # Update the location record date to show that it has been updates
      location_record.update({ updated: date })
    end
 handle_asynchronously :analyse
end