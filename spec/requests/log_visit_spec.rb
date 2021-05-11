require 'rails_helper'

# Tests requests to the LogVisitController
RSpec.describe 'LogVisits', type: :request do
  let(:log_visitor) do
    lambda do
      get '/statistics/log_visit'
    end
  end

  let(:get_visit_count) do
    lambda do
      get '/statistics/get_visit_count'
    end
  end

  describe 'GET /statistics/log_visit' do
    context 'when valid parameters are used' do
      it 'should add visit to database' do
        log_visitor.call
        entry = Visit.all.count
        expect(entry).to eq(1)
      end
    end
  end

  describe 'GET /statistics/get_visit_count' do
    context 'when valid parameters are used' do
      it 'should get correct visit count from database' do
        log_visitor.call
        get_visit_count.call

        expect(response.status).to eq(200)
        expect(response.body).to eq('{"count":1}')
      end
    end
  end
end
