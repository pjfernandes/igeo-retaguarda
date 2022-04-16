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

  def self.to_csv(records = [])
    CSV.generate(headers: true, col_sep: ";") do |csv|
      csv << ["longitude", "latitude", "name", "date", "time", "description"]

      records.each do |point|
        date_point = eval(point.date)[3].to_s + "/" + eval(point.date)[2].to_s + "/" + eval(point.date)[1].to_s
        time_point = eval(point.time)[4].to_s + ":" + eval(point.time)[5].to_s
        row = [point.longitude, point.latitude, point.name, date_point, time_point, point.description]
        csv << row
      end
    end
  end

end
