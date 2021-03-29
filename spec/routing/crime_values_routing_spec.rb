require "rails_helper"

RSpec.describe CrimeValuesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/crime_values").to route_to("crime_values#index")
    end

    it "routes to #show" do
      expect(get: "/crime_values/1").to route_to("crime_values#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/crime_values").to route_to("crime_values#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/crime_values/1").to route_to("crime_values#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/crime_values/1").to route_to("crime_values#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/crime_values/1").to route_to("crime_values#destroy", id: "1")
    end
  end
end
