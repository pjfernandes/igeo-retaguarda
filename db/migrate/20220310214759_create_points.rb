class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.string :date
      t.string :time
      t.string :description

      t.timestamps
    end
  end
end
