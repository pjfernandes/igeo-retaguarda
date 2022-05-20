class AddUserToSubjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :subjects, :user, null: false, foreign_key: true
  end
end
