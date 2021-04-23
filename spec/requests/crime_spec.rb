require 'rails_helper'

RSpec.describe '/crime', type: :request do
  let(:successful_request) do
    # Produces a Lambda function containing a successful request
    lambda do
      get '/crime/crime?poly=52.268,0.543:52.794,0.238:52.130,0.478'
    end
  end

  let(:invalid_request) do
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
        expect(crime['category']).not_to be_nil
        expect(crime['crime_date']).not_to be_nil
        expect(crime['street']).not_to be_nil
        expect(crime['extra_info']).not_to be_nil
        expect(crime['latitude']).not_to be_nil
        expect(crime['longitude']).not_to be_nil

      end
    end
  end

  context 'when a successful response is not received' do
    it 'should raise an error' do
      expect { invalid_request.call }.to raise_error(RestClient::NotFound)
    end
  end
end
