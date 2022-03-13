class Subject < ApplicationRecord
  validates :name, presence: true

  has_many :points
  has_one_attached :photo
end
