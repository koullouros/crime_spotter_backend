require "test_helper"

class CrimeControllerTest < ActionDispatch::IntegrationTest
  test "should get crime" do
    get crime_crime_url
    assert_response :success
  end
end
