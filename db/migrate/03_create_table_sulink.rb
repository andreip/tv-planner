class CreateTableSulink < ActiveRecord::Migration
  def up
    create_table :series_users_links do |t|
      t.references :user
      t.references :serie
      t.boolean	   :saw
    end
  end

  def down
    drop_table :series_users_links
  end
end
