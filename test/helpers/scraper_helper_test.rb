require 'test_helper'

class ScraperHelperTest < ActionView::TestCase
  include ScraperHelper

  test 'Should return scraped data (google_scraper)' do

    articles = google_scraper('test')

    assert_not_empty articles
  end

  test 'Should return 10 articles (google_scraper)' do
    #Note: 10 articles may not be returned in website use due to query being too specific

    articles = google_scraper('test')

    assert_equal(10, articles.length)
  end

  test 'Should have title, url and description to every article (google_scraper)' do

    articles = google_scraper('test')

    articles.each do |article|
      assert_not_nil article[:title]
      assert_not_nil article[:url]
      assert_not_nil article[:description]
    end

  end


end