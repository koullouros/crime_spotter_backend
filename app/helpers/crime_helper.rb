require 'rest-client'
require 'json'

module CrimeHelper

  def crime_helper(coordinates, date)

    resp = RestClient.get("https://data.police.uk/api/crimes-street/all-crime?poly=#{coordinates}&date=#{date}")
    json = JSON.parse(resp.body)

    crimes = []

    json.each do |item|
      outcome_status = nil
      outcome_date = nil

      if item['outcome_status'] != nil
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

