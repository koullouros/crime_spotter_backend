require 'rest-client'
require 'json'

class Crime
  attr_reader :category, :crime_date, :street, :outcome_status, :outcome_date, :extra_info

  def initialize(category, crime_date, street, outcome_status, outcome_date, extra_info)
    @category = category
    @crime_date = crime_date
    @street = street
    @outcome_status = outcome_status
    @outcome_date = outcome_date
    @extra_info = extra_info

  end

  def to_s
    "#{@category} | #{@crime_date} | #{@street} | #{@outcome_status} | #{@outcome_date} | #{@extra_info}"
  end

end

module CrimeHelper

end

date = "2020-12"
latitude = "52.629729"
longitude = "-1.131592"

resp = RestClient.get("https://data.police.uk/api/crimes-at-location?date=#{date}&lat=#{latitude}&lng=#{longitude}")
json = JSON.parse(resp.body)

crimes = []

json.each_with_index do |item,index|
  category = item['category']
  crime_date = item['month']
  street = item['location']['street']['name']
  outcome_status = item['outcome_status']['category']
  outcome_date = item['outcome_status']['date']
  extra_info = item['context']

  crimes.push(Crime.new(category, crime_date, street, outcome_status, outcome_date, extra_info))
end

crimes.each do |crime|
  puts crime.to_s
end

