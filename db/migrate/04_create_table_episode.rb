class CreateTableEpisode < ActiveRecord::Migration
  def up
    create_table :episodes do |t|
      t.references :serie
      t.string     :name
      t.integer	   :episode_nr
      t.integer    :season_nr
      t.datetime   :airdate
    end
  end

  def down
    drop_table :episodes
  end
end
