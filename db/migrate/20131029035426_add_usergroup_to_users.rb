class AddUsergroupToUsers < ActiveRecord::Migration
  def change
    add_column :users, :usergroup, :integer, :default => 1
  end
end
