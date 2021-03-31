class Location < ApplicationRecord
  validates :name, :updated, presence: true
  has_many :crime_entries
end
