require 'rails_helper'

RSpec.describe ScraperHelper, type: :helper do
  before do
    allow(Rails.cache).to receive(:read).with('cse:guardian').and_return(refresh_cse_token('guardian'))
    allow(Rails.cache).to receive(:read).with('cse:independent').and_return(refresh_cse_token('independent'))
  end

  let(:google_query) do
    google_scraper('test')
  end
  let(:independent_query) do
    cse_scraper('test', 'independent')
  end
  let(:guardian_query) do
    cse_scraper('test', 'guardian')
  end

  let(:invalid_query) do
    cse_scraper(nil, 'google')
  end

  describe 'cse_scraper' do
    context 'provided with a valid query and google as the source' do
      it 'should return scraped data' do
        expect(google_query).not_to be_empty
      end

      it 'should return exactly 10 articles' do
        expect(google_query.length).to eq(10)
      end

      it 'should return articles with titles, urls and descriptions' do
        google_query.each do |article|
          expect(article[:title]).not_to be_nil
          expect(article[:url]).not_to be_nil
          expect(article[:description]).not_to be_nil
        end
      end
    end

    context 'provided with a valid query and The Independent as the source' do
      it 'should return scraped data' do
        expect(independent_query).not_to be_empty
      end

      it 'should return exactly 10 articles' do
        expect(independent_query.length).to eq(10)
      end

      it 'should return articles with titles, urls and descriptions' do
        independent_query.each do |article|
          expect(article[:title]).not_to be_nil
          expect(article[:url]).not_to be_nil
          expect(article[:description]).not_to be_nil
        end
      end
    end

    context 'provided with a valid query and The Guardian as the source' do
      it 'should return scraped data' do
        expect(guardian_query).not_to be_empty
      end

      it 'should return exactly 10 articles' do
        expect(guardian_query.length).to eq(10)
      end

      it 'should return articles with titles, urls and descriptions' do
        guardian_query.each do |article|
          expect(article[:title]).not_to be_nil
          expect(article[:url]).not_to be_nil
          expect(article[:description]).not_to be_nil
        end
      end
    end

    context 'provided with a nil query' do
      it 'should return nil' do
        expect(invalid_query).to be_nil
      end
    end
  end

end
