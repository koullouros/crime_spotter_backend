require 'rails_helper'

RSpec.describe Location, type: :model do
  # Create valid location
  subject do
    described_class.new(name: 'Location1',
                        updated: '2021-02-01')
  end

  # Test associations defined in location.rb model
  describe 'associations' do
    it { should have_many(:crime_entries) }
  end

  # Test validations defined in location.rb model
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:updated) }
    it { should validate_uniqueness_of(:name) }
  end


end
