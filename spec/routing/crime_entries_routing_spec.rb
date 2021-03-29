require "rails_helper"

RSpec.describe CrimeEntriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/crime_entries").to route_to("crime_entries#index")
    end

    it "routes to #show" do
      expect(get: "/crime_entries/1").to route_to("crime_entries#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/crime_entries").to route_to("crime_entries#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/crime_entries/1").to route_to("crime_entries#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/crime_entries/1").to route_to("crime_entries#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/crime_entries/1").to route_to("crime_entries#destroy", id: "1")
    end
  end
end
