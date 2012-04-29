class User < ActiveRecord::Base

  def self.check_unique(email)
    return User.where(:email => email).first.nil?
  end

  def subscribe_to_serie serie
    new_link = Series_users_link.new(:user_id => self.id ,
                                     :serie_id => serie.id)
    new_link.save();
  end

  def subscribe_to_serie_by_id serie_id
    new_link = Series_users_link.new(:user_id => self.id ,
                                     :serie_id => serie_id)
    new_link.save();
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

  def get_subscribed_series
    links = Series_users_link.where(:user_id => self)   
    series = Array.new;

    links.each do |l|
      series << Serie.where(:id => l[:serie_id]).first
    end

    return series
  end

  def get_subscribed_series_ids
    links = Series_users_link.where(:user_id => self)
    series = Array.new;
    links.each do |l|
      series << l[:serie_id]
    end

    return series
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

    return messages
  end

  def has_password?(submitted_password)
    self.password == User.encrypt(submitted_password)
  end

  def encrypt_password
    unless has_password?(password)
      self.encrypted_password = encrypt("#{password}")
    end
  end

  def self.encrypt(pass)
    Digest::SHA2.hexdigest(pass)
  end
end
