require "rails_helper"

RSpec.describe CrimesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/crimes").to route_to("crimes#index")
    end

    it "routes to #show" do
      expect(get: "/crimes/1").to route_to("crimes#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/crimes").to route_to("crimes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/crimes/1").to route_to("crimes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/crimes/1").to route_to("crimes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/crimes/1").to route_to("crimes#destroy", id: "1")
    end
  end
end
