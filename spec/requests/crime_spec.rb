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
    it 'it should provide a 200 status code' do
      successful_request.call
      expect(response.status).to eq(200)
    end
  end

  context 'when a successful response is not received' do
    it 'should raise an error' do
      expect { failed_request.call }.to raise_error(RestClient::NotFound)
    end
  end
end
