require 'rails_helper'

RSpec.describe 'LogSearches', type: :request do
  let(:submit_search_term) do
    lambda do
      Search.create(term: 'test_search_term')
    end
  end

  let(:get_search_count) do
    lambda do
      get '/statistics/get_search_count'
    end
  end

  describe 'Log Search' do
    context 'with a valid search term' do
      it 'should add term to database' do
        submit_search_term.call
        entry = Search.find_by(term: 'test_search_term')

        expect(entry).not_to be_nil
        expect(entry.term).to eq('test_search_term')
      end
    end
  end

  describe 'GET /statistics/get_search_count' do
    it 'should get correct search count from database' do
      submit_search_term.call
      get_search_count.call

      expect(response.status).to eq(200)
      expect(response.body).to eq('{"count":1}')
    end
  end
end
