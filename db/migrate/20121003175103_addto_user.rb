class AddtoUser < ActiveRecord::Migration
def change
    add_column :users, :confirmed, :boolean, :default => false
    add_column :users, :token_at, :datetime
    add_column :users, :activetion_code, :string
  end
end
