require "bundler/setup"

Bundler.require :default

Dir.glob("models/*").each { |f| require File.expand_path(f) }

class Tv_planner < Sinatra::Base
  enable :static
  enable :sessions

  configure do
    set :database, "sqlite://development.sql"
  end

  get "/" do
    if session[:token].nil?
      erb :login
    else
      redirect "/dashboard"
    end
  end

  get "/register" do
    erb :register
  end

  post "/register" do
    if User.check_unique(params[:email])
      user = User.new(:email => params[:email], :password => User.encrypt(params[:password]))
      if !user.save
        @error_message = "A fost o eroare cand am salvat utilizatorul. Incearca din nou"
        redirect_to "/"
      else
        session[:token] = "#{user.email}"
        redirect "/dashboard"
      end
    else
      "User email is already in use"
    end
  end

  post "/sessions/create" do
    user = User.where(:email => params[:email]).first;
    if user.nil?
      erb :login
    elsif user.has_password?(params[:password])
      puts "user ok password"
      session[:token]= "#{user.email}"
      redirect "/dashboard"
    else
      puts "user wrong pass"
      erb :login
    end
  end

  get "/remove-subscribtion" do
    if session[:token].nil?
      erb :login
    else
      usr = User.where(:email => session[:token]).first;
      rec = Series_users_link.where(:user_id => usr.id,
                                    :serie_id => params[:id])
      Series_users_link.delete(rec)
      redirect "/dashboard"
    end
  end

  get "/dashboard" do
    if session[:token].nil?
      erb :login
    else
      @user = User.where(:email => session[:token]).first;
      @my_series = @user.get_subscribed_series()
      puts @my_series.inspect
      erb :index
    end
  end

  get "/mark_seen" do
    if session[:token].nil?
      erb :login
    else
      message = Message.where(:id => params[:id]).first
      message.read = true
      message.save()
      redirect "/reminders"
    end
  end

  get "/reminders" do
    if session[:token].nil?
      erb :login
    else
      @user = User.where(:email => session[:token]).first;
      @alerts = @user.get_current_alerts()
      erb :reminders
    end
  end

  get "/subscribe" do
    if session[:token].nil?
      erb :login
    else
      user = User.where(:email => session[:token]).first;
      ret = Series_users_link.where(:user_id => user.id,
                                    :serie_id => params[:id])
      if ret.first.nil? === false
        redirect "/all-series"  
      end
      user.subscribe_to_serie_by_id( params[:id] )
      user.save()
      redirect "/all-series"
    end
  end

  get "/all-series" do
    if session[:token].nil?
      erb :login
    else
      @user = User.where(:email => session[:token]).first;
      @all_series = Serie.all()
      erb :all_series
    end
  end

  get "/user" do
    if session[:token].nil?
      erb :login
    else
      @user= User.where(:email => session[:token]).first
      erb :user
    end
  end

  not_found do
    status 404
    erb :not_found
  end

  get "/logout" do
    if session[:token].nil?
      erb :login
    else
      session[:token] = nil
      redirect "/"
    end
  end
end
