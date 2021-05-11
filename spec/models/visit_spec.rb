require 'rails_helper'

# Tests the schema is being enforced on creation of search visit entries
RSpec.describe Visit, type: :model do
  subject do
    described_class.new
  end
end
