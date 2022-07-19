class Subject < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }

  has_many :points
  has_one_attached :photo
end
