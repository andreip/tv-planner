class Series_users_link < ActiveRecord::Base
  belongs_to :user
  belongs_to :serie
end
