class CreateTableSerie < ActiveRecord::Migration
  def up
    create_table :series do |t|
      t.integer :show_id
      t.string  :name
      t.string  :clasifiscat
      t.string  :url
      t.integer :last_episode_num
      t.string  :last_episode_airdate
    end
  end

  def down
    drop_table :serial
  end
end
