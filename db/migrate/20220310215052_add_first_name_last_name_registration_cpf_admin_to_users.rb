class AddFirstNameLastNameRegistrationCpfAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :registration, :string
    add_column :users, :cpf, :string
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
