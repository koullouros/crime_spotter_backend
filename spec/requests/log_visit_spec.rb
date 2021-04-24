require 'rails_helper'

RSpec.describe 'LogVisits', type: :request do
  let(:log_visitor) do
    lambda do
      post '/log_visit/log_visit', params: { page: 'test_page',
                                             ip: '0.0.0.0',
                                             location: 'test_location' }
    end
  end

  let(:get_visit_count) do
    lambda do
      post '/log_visit/get_visit_count', params: { page: 'test_page' }
    end
  end

  describe 'POST /log_visit/log_visit' do
    context 'when valid parameters are used' do
      it 'should add visit to database' do
        log_visitor.call
        entry = Visit.find_by(page: 'test_page', ip_address: '0.0.0.0', location: 'test_location')
        expect(entry).not_to be_nil
      end
    end
  end

  describe 'POST /log_visit/get_visit_count' do
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
