class CrimeEntry < ApplicationRecord
  belongs_to :location
  validates :location, :name, :value, :month, presence: true
  validates :name, uniqueness: { scope: :month }
end
