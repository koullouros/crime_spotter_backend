require 'rails_helper'

# Tests the schema is being enforced on creation of search entries
RSpec.describe Search, type: :model do
  subject do
    described_class.new(term: 'Location1')
  end

  describe 'validations' do
    it { should validate_presence_of(:term) }
  end
end
