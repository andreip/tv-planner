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
