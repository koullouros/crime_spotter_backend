class CrimeEntry < ApplicationRecord
  validates :location, :name, :value, :month, presence: true
  belongs_to :location
end
