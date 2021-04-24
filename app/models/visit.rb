class Visit < ApplicationRecord
  validates :page, presence: true
  validates :ip_address, presence: true
  validates :location, presence: true
end
