class ProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :website, :string
    add_column :users, :location, :string
    add_column :users, :biblography, :string

  end
end