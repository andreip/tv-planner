class AddMockupUser < ActiveRecord::Migration
	User.new(:email => "adrian.stratulat@cti.pub.ro",
		     :password => "a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3").save()
	User.new(:email => "still_me@internetz",
			 :password => "p").save()
end