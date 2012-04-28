class AddMockupLinks < ActiveRecord::Migration
	def up
		usr = User.where(:email => "adrian.stratulat@cti.pub.ro").first;
		sr1 = Serie.where(:name => "Doctor Who").first;
		sr2 = Serie.where(:name => "Fringe").first;

		usr.subscribe_to_serie(sr1);
		usr.subscribe_to_serie(sr2);
	end
end
