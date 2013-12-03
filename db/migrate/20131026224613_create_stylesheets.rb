class CreateStylesheets < ActiveRecord::Migration
  def change
    create_table :stylesheets do |t|
      t.text :code

      t.timestamps
    end
  end
end
