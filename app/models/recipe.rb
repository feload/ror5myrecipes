class Recipe < ApplicationRecord
  # belongs_to  :chef
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end