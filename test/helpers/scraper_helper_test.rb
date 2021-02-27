require 'test_helper'

class ScraperHelperTest < ActionView::TestCase
  include ScraperHelper

  test "Should return scraped data" do
    assert_not_empty google_scraper("test")
  end



end