require 'rails_helper'

RSpec.describe Visit, type: :model do
  subject do
    described_class.new(ip_address: 'example_ip')
  end

  describe 'validations' do
    it { should validate_presence_of(:ip_address) }
  end
end
