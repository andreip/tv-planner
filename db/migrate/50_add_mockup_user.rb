class AddMockupUser < ActiveRecord::Migration
	def up
		User.new(:email => "adrian.stratulat@cti.pub.ro", :password => "p")
		User.new(:email => "still_me@internetz", :password => "p")
	end
end