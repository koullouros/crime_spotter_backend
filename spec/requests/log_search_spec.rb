require 'rails_helper'

RSpec.describe 'LogSearches', type: :request do
  let(:submit_search_term) do
    lambda do
      post '/log_search/log_search', params: { search_term: 'test_search_term' }
    end
  end

  let(:get_search_term_count) do
    lambda do
      post '/log_search/get_search_term_count', params: { search_term: 'test_search_term' }
    end
  end

  describe 'POST /log_search/log_search' do
    context 'with a valid search term' do
      it 'should add term to database' do
        submit_search_term.call
        entry = Search.find_by(term: 'test_search_term')

        expect(entry).not_to be_nil
        expect(entry.term).to eq('test_search_term')
      end
    end
  end

  describe 'POST /log_search/get_search_term_count' do
    context 'with a valid search term' do
      it 'should get correct search term count from database' do
        submit_search_term.call
        get_search_term_count.call

        expect(response.status).to eq(200)
        expect(response.body).to eq('1')
      end
    end
  end
end
