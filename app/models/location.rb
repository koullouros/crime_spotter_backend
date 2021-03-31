class Location < ApplicationRecord
  validates :name, :updated, presence: true
  validates :name, uniqueness: true
  has_many :crime_entries
end
