require 'rest-client'
require 'json'

module CrimeHelper

  def get_latest_crime_date
    # Retrieves the latest date that crime is available for using the data police API
    resp = RestClient.get('https://data.police.uk/api/crime-last-updated')
    JSON.parse(resp)['date']
  end

  def crime_helper(coordinates)
    # Uses passed in coordinates to retrieve the levels of crime in the area
    return nil if coordinates.nil?

    # Retrieve street level crimes from data police API at coordinates
    resp = RestClient.post('https://data.police.uk/api/crimes-street/all-crime', poly: coordinates, date: get_latest_crime_date[0..6])
    json = JSON.parse(resp.body)

    crimes = []

    # Add each crime entry to an array in easier form for frontend to read
    json.each do |item|
      outcome_status = nil
      outcome_date = nil

      # Checks if crime has an outcome status as sometimes they aren't provided
      # If there is, they are defined and added to the data structure
      unless item['outcome_status'].nil?
        outcome_status = item['outcome_status']['category']
        outcome_date = item['outcome_status']['date']
      end

      crimes.push(
        category: item['category'],
        crime_date: item['month'],
        street: item['location']['street']['name'],
        outcome_status: outcome_status,
        outcome_date: outcome_date,
        extra_info: item['context'],
        latitude: item['location']['latitude'],
        longitude: item['location']['longitude']
      )
    end

    crimes
  end
end
