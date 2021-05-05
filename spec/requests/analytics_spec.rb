require 'rails_helper'

RSpec.describe 'Analytics', type: :request do
  let(:successful_request) do
    # Produces a Lambda function containing a successful request
    lambda do
      get '/statistics/city?name=bracknell'
    end
  end

  let(:invalid_request) do
    # This Lambda function contains an invalid request
    lambda do
      get '/statistics/city?name='
    end
  end

  describe 'GET /statistics/city' do
    context 'when valid parameters are used' do
      it 'should provide a 200 status code' do
        successful_request.call
        expect(response.status).to eq(200)
      end
    end

    context 'when invalid parameters are used' do
      it 'should raise an error' do
        expect { invalid_request.call }.to raise_error(NoMethodError)
      end
    end
  end
end
