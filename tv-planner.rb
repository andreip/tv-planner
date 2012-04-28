require "bundler/setup"

Bundler.require :default

class User < ActiveRecord::Base
  def subscribe_to_serie serie
    new_link = Series_users_link.new(:user => self,
      :serie => serie)
    new_link.save();
  end

  def get_subscribed_series
    Series_users_link.where(:user => self)
  end

  def get_current_alerts
    series = get_subscribed_series()

    # bad idea !
    now = "acum"
    current = Array.new;

    series.each do |s|
      if s[:next_episode_airdate] === now
        current << s
      end
    end
  end
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
    erb :login
  end

  get "/index" do 
    erb :index
  end

  get "/register" do
    erb :register
    #user = User.new(params[:user])
    #redirect "/"
  end

  get "/dashboard" do
    @user = User.where(:email => "adrian.stratulat@cti.pub.ro").first;
    @all_series = @user.get_subscribed_series()
    @alerts = @user.get_current_alerts()
  erb :dashboard
  end

end
