require 'rails_helper'

RSpec.describe CrimeEntry, type: :model do
  # Create valid location
  location = Location.new(name: 'Anything',
                          updated: '2021-02-01')

  # Create valid instance of what a crime_entry should look like
  subject do
    described_class.new(name: 'Anything',
                        value: 50,
                        month: '2021-02-01',
                        location: location)
  end

  # Test associations defined in crime_entry.rb model
  describe 'associations' do
    it { should belong_to(:location) }
  end

  # Test validations defined in crime_entry.rb model
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:month) }
    it { should validate_presence_of(:location) }
    it { should validate_uniqueness_of(:name).scoped_to(:location_id) }
  end

end
