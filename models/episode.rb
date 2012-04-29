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
