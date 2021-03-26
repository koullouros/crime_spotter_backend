require 'rails_helper'

RSpec.describe "Analytics", type: :request do
  describe "GET /analytics" do
    it "returns http success" do
      get "/analytics/analytics"
      expect(response).to have_http_status(:success)
    end
  end

end
