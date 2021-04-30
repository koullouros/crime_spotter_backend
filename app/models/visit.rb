class Visit < ApplicationRecord
  validates :ip_address, presence: true
end
