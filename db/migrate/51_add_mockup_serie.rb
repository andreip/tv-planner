class AddMockupSerie < ActiveRecord::Migration
	Serie.new(:name => "Doctor Who",
				:show_id => 0,
				:clasifiscat => "awesome",
				:url => "blahblah",
				:last_episode_num => 9,
				:last_episode_airdate => "la toamna").save()

	Serie.new(:name => "Fringe",
				:show_id => 1,
				:clasifiscat => "awesome",
				:url => "...",
				:last_episode_num => 9,
				:last_episode_airdate => "acum").save()
end
