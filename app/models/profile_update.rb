class ProfileUpdate < ActiveRecord::Base
  extend Enumerize
  belongs_to :customer
  belongs_to :address

  enumerize :state, :in => {
    :track    => 1,
    :area     => 2,
    :day      => 3,
    :complete => 4,
    :applied  => 5
  }, :default => :track

  # TODO: rename those in db
  def track_ids
    tracks || []
  end

  def track_ids=(new_track_ids)
    send(:tracks=, new_track_ids)
  end

  def lunch_days
    lunch || []
  end

  def lunch_days=(new_lunch_days)
    send(:lunch=, new_lunch_days)
  end

  def dinner_days
    dinner || []
  end

  def dinner_days=(new_dinner_days)
    send(:dinner=, new_dinner_days)
  end
end
