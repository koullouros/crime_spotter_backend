require 'rails_helper'

RSpec.describe Visit, type: :model do
  subject do
    described_class.new(page: 'example_page',
                        ip_address: 'example_ip',
                        location: 'example_location')
  end

  describe 'validations' do
    it { should validate_presence_of(:page) }
    it { should validate_presence_of(:ip_address) }
    it { should validate_presence_of(:location) }
  end
end
