require 'rails_helper'

RSpec.describe 'LogVisits', type: :request do
  let(:log_visitor) do
    lambda do
      post '/statistics/log_visit', params: { ip: '0.0.0.0' }
    end
  end

  let(:get_visit_count) do
    lambda do
      get '/statistics/get_visit_count'
    end
  end

  describe 'POST /statistics/log_visit' do
    context 'when valid parameters are used' do
      it 'should add visit to database' do
        log_visitor.call
        entry = Visit.find_by(ip_address: '0.0.0.0')
        expect(entry).not_to be_nil
      end
    end
  end

  describe 'GET /statistics/get_visit_count' do
    context 'when valid parameters are used' do
      it 'should get correct visit count from database' do
        log_visitor.call
        get_visit_count.call

        expect(response.status).to eq(200)
        expect(response.body).to eq('1')
      end
    end
  end
end
