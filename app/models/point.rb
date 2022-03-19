class Point < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :date, :description ],
    associated_against: {
       subject: [ :name ]
     },
    using: {
      tsearch: { prefix: true }
    }
end
