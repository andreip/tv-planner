class AddMockupSerie < ActiveRecord::Migration
	Serie.new(:name => "Doctor Who",
				:show_id => 3332,
				:clasifiscat => "awesome",
				:url => "blahblah").save()

	Serie.new(:name => "Fringe",
				:show_id => 18388,
				:clasifiscat => "awesome",
				:url => "...").save()

	Serie.new(:name => "Glee",
				:show_id => 21704,
				:clasifiscat => "not awesome",
				:url => "...").save()

	Serie.new(:name => "Californication",
				:show_id => 15319,
				:clasifiscat => "awesome",
				:url => "...").save()	
end
