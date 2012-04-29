require "bundler/setup"

Bundler.require :default

class User < ActiveRecord::Base

  def self.check_unique(email)
    return User.where(:email => email).first.nil?
  end


  def subscribe_to_serie serie
    new_link = Series_users_link.new(:user_id => self.id ,
                                     :serie_id => serie.id,
                                     :saw => false)
    new_link.save();
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
    series = get_subscribed_series()
    current = Array.new;

    now = "acum"

    series.each do |s|
      if s.last_episode_airdate === now
        current << s
      end
    end

    return current;
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

  get "/register" do
    erb :register
    #user = User.new(params[:user])
    #redirect "/"
  end

  get "/dashboard" do
    @user = User.where(:email => "adrian.stratulat@cti.pub.ro").first;
    @all_series = @user.get_subscribed_series()
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
