class AddMockupUser < ActiveRecord::Migration
	User.new(:email => "adrian.stratulat@cti.pub.ro", :password => "p").save()
	User.new(:email => "still_me@internetz", :password => "p").save()
end