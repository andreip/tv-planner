require "bundler/setup"

Bundler.require :default

class User < ActiveRecord::Base
end

class Serie < ActiveRecord::Base
end

class Series_users_link < ActiveRecord::Base
	belongs_to :user
	belongs_to :serie
end

class Tv_planner < Sinatra::Base
  enable :static
  enable :sessions

  configure do
    set :database, "sqlite://development.sql"
  end

  get "/" do
    "HEllo"
    erb :login
  end
end
