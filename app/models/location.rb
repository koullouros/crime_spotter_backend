class Location < ApplicationRecord
  has_many :crime_entries
  validates :name, :updated, presence: true
  validates :name, uniqueness: true
end
