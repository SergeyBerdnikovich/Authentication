class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :fullname
      t.string :email
      t.string :password_digest
      t.boolean :two_step_auth

      t.timestamps
    end
  end
end
