class AddMockupSerie < ActiveRecord::Migration
	sr = Serie.new(:name => "Doctor Who",
				:show_id => 0,
				:clasifiscat => "awesome",
				:url => "blahblah",
				:next_episode_num => 9,
				:next_episode_airdate => "la toamna").save()
end
