require 'rails_helper'

RSpec.describe ScraperHelper, type: :helper do
  let(:valid_query) do
    google_scraper('test')
  end

  let(:invalid_query) do
    google_scraper(nil)
  end

  context 'providing google_scraper with a valid query' do
    it 'should return scraped data (google_scraper)' do
      expect(valid_query).not_to be_empty
    end

    it 'should return exactly 10 articles (google_scraper)' do
      expect(valid_query.length).to eq(10)
    end

    it 'should return articles with titles, urls and descriptions' do
      valid_query.each do |article|
        expect(article[:title]).not_to be_nil
        expect(article[:url]).not_to be_nil
        expect(article[:description]).not_to be_nil
      end
    end
  end

  context 'providing google_scraper with a nil query' do
    it 'should return nil' do
      expect(invalid_query).to be_nil
    end
  end
end
