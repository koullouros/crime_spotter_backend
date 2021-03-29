class CrimeEntry < ApplicationRecord
  belongs_to :location
  has_one :crime_type
end
