class CreateTableUser < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string  :email
      t.string  :password
      t.boolean :active
    end
  end

  def down
    drop_table :user
  end
end
