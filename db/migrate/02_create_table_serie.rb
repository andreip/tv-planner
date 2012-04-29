class CreateTableSerie < ActiveRecord::Migration
  def up
    create_table :series do |t|
      t.integer :show_id
      t.string  :name
      t.string  :clasifiscat
      t.string  :url
    end
  end

  def down
    drop_table :series
  end
end
