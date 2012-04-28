class AddMockupLinks < ActiveRecord::Migration
	def up
		usr = User.where(:email => "adrian.stratulat@cti.pub.ro").first;
		sr = Serie.where(:name => "Doctor Who").first;

		Series_users_link.new(:user => usr,
						      :serie => sr).save();
	end
end
