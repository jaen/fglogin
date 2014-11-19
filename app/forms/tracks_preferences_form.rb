class TracksPreferencesForm < FormObject
  attribute :track_ids, Array[Integer]

  def execute(profile_update)
    if profile_update.state == 'track' && valid?
      profile_update.track_ids = track_ids
      profile_update.state     = :area

      profile_update.save
    else
      false
    end
  end

  protected
    VALIDATOR = Vanguard::Validator.build do
      validates_presence_of :track_ids
    end
end
