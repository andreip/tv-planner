require "bundler/setup"

Bundler.require :default

class User < ActiveRecord::Base
end

class Series < ActiveRecord::Base
end

class Series_users_link < ActiveRecord::Base
end

class Tv_planner < Sinatra::Base
  enable :static
  enable :sessions

  configure do
    set :database, "sqlite://development.sql"
  end

  get "/" do
    erb :login
  end

  get "/register" do
    erb :register
  end
end
