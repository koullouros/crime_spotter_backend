class Search < ApplicationRecord
  validates :term, presence: true
end
