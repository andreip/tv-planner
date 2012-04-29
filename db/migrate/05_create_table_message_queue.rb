class CreateTableMessageQueue < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.references :user
      t.references :episode
      t.boolean	   :read
    end
  end

  def down
    drop_table :messages
  end
end
