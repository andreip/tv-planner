class AddMockupEpisodes < ActiveRecord::Migration
	def up
		sr = Serie.where(:name => "Doctor Who").first;

    sr.add_episode("ultimu", DateTime.now, 1, 1, true);
	end
end
