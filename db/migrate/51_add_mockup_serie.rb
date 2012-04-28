class AddMockupSerie < ActiveRecord::Migration
	Serie.new(:name => "Doctor Who",
				:show_id => 0,
				:clasifiscat => "awesome",
				:url => "blahblah",
				:next_episode_num => 9,
				:next_episode_airdate => "la toamna").save()

	Serie.new(:name => "Fringe",
				:show_id => 1,
				:clasifiscat => "awesome",
				:url => "...",
				:next_episode_num => 9,
				:next_episode_airdate => "acum").save()
end
