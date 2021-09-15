class AddBabyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :baby, :string
  end
end
