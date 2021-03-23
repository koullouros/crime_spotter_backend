require 'rails_helper'

RSpec.describe 'Crimes' do
  let(:successful_request) do
    # Produces a Lambda function containing a successful request
    lambda do
      get '/crime/crime?poly=52.268,0.543:52.794,0.238:52.130,0.478&date=2021-01'
    end
  end

  let(:failed_request) do
    # This Lambda function contains an invalid request
    lambda do
      get '/crime/crime?poly=??'
    end
  end

  context 'when a successful response is received' do
    it 'should provide a 200 status code' do
      successful_request.call
      expect(response.status).to eq(200)
    end

    it 'should contain all the required information' do
      successful_request.call

      crimes = JSON.parse(response.body)

      crimes.each do |crime|
        # Check each component of the crime
        # outcome status and date aren't checked as they are nil quite often
        assert !crime['category'].nil?
        assert !crime['crime_date'].nil?
        assert !crime['street'].nil?
        assert !crime['extra_info'].nil?
        assert !crime['latitude'].nil?
        assert !crime['longitude'].nil?

      end
    end

  end

  context 'when a successful response is not received' do
    it 'should raise an error' do
      expect { failed_request.call }.to raise_error(RestClient::NotFound)
    end
  end
end
