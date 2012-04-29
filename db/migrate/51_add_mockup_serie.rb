class AddMockupSerie < ActiveRecord::Migration
	Serie.new(:name => "Doctor Who",
				:show_id => 0,
				:clasifiscat => "awesome",
				:url => "blahblah").save()

	Serie.new(:name => "Fringe",
				:show_id => 1,
				:clasifiscat => "awesome",
				:url => "...").save()

	Serie.new(:name => "Glee",
				:show_id => 7,
				:clasifiscat => "not awesome",
				:url => "...").save()
end
