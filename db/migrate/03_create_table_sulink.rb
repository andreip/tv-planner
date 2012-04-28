class CreateTableSulink < ActiveRecord::Migration
  def up
    create_table :series_users_link do |t|
      t.references :user
      t.references :series
    end
  end

  def down
    drop_table :series_users_link
  end
end
