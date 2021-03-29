require "rails_helper"

RSpec.describe CrimeTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/crime_types").to route_to("crime_types#index")
    end

    it "routes to #show" do
      expect(get: "/crime_types/1").to route_to("crime_types#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/crime_types").to route_to("crime_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/crime_types/1").to route_to("crime_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/crime_types/1").to route_to("crime_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/crime_types/1").to route_to("crime_types#destroy", id: "1")
    end
  end
end
