class Subject < ApplicationRecord
  has_many :points
  has_one_attached :photo
end
