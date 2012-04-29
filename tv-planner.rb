require "bundler/setup"

Bundler.require :default

class User < ActiveRecord::Base

  def self.check_unique(email)
    return User.where(:email => email).first.nil?
  end


  def subscribe_to_serie serie
    new_link = Series_users_link.new(:user_id => self.id ,
                                     :serie_id => serie.id)
    new_link.save();
  end


  def enqueue_message episode_id
    new_message = Message.new(:user_id => self.id,
                              :episode_id => episode_id,
                              :read => false)
    new_message.save()
  end


  def dequeue_messages
    messages = Message.where(:user_id => self.id,
                             :read => false)
    messages.each do |m|
      m.read = true
      m.save()
    end

    return messages
  end


  def get_subscribed_series
    links = Series_users_link.where(:user_id => self)   
    series = Array.new;

    links.each do |l|
      series << Serie.where(:id => l[:serie_id]).first
    end

    return series
  end


  def get_current_alerts
    messages = dequeue_messages();
    puts messages.inspect

    ret = Array.new;

    messages.each do |l|
      ret << Episode.where(:id => l[:episode_id]).first
    end

    return ret
  end

end

class Serie < ActiveRecord::Base

  def add_episode(name, airdate, episode_nr, season_nr, broadcast)
    ep = Episode.new( :serie_id => self.id,
                      :name => name,
                      :episode_nr => episode_nr,
                      :season_nr => season_nr,
                      :airdate => airdate)

    ep.save()

    if broadcast === true
      ep.notify_all_subscribed()
    end

  end
end

class Episode < ActiveRecord::Base
  belongs_to :serie

  def notify_all_subscribed
    subscribers = Series_users_link.where(:serie_id => self.serie_id)

    subscribers.each do |s|
      u = User.where(:id => s[:user_id]).first
      u.enqueue_message(self.id)
    end

  end
end

class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode
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

  get "/register" do
    erb :register
    #user = User.new(params[:user])
    #redirect "/"
  end

  get "/dashboard" do
    @user = User.where(:email => "adrian.stratulat@cti.pub.ro").first;
    @my_series = @user.get_subscribed_series()
    puts @my_series.inspect
    erb :index
  end

  get "/reminders" do
    @user = User.where(:email => "adrian.stratulat@cti.pub.ro").first;
    @alerts = @user.get_current_alerts()
    erb :reminders
  end

  get "/all-series" do
    @user = User.where(:email => "adrian.stratulat@cti.pub.ro").first;
    @all_series = Serie.all()
    erb :all_series
  end
  
  post "/register" do
    if User.check_unique(params[:email]) 
    	user =  User.new(:email => params[:email], :password => params[:password])
    	if !user.save 
      	@error_message = "A fost o eroare cand am salvat utilizatorul. Incearca din nou"
      	redirect_to "/"
      	return
    	end
    	redirect "/dashboard"
    else 
    	"User email is already in use"
    end
  end
  
  get "/user" do
  	@user= User.where(:email => "adrian.stratulat@cti.pub.ro").first
  	puts @user.inspect
  	#if @user.nil?
  	#	redirect "/dashboard"
  	#end
  	erb :user
  end

  not_found do
    status 404
    erb :not_found
  end
end

