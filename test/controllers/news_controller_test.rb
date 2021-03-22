require "test_helper"

class NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get news_news_url
    assert_response :success
  end
end
