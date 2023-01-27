class AddFavoriteToPoints < ActiveRecord::Migration[7.0]
  def change
    add_column :points, :favorite, :boolean, null: false, default: false
  end
end
