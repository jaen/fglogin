class DayPreferencesForm < FormObject
  attribute :lunch_days,  Array[Symbol]
  attribute :dinner_days, Array[Symbol]

  def execute(profile_update)
    if profile_update.state == 'day' && valid?
      profile_update.lunch_days  = lunch_days
      profile_update.dinner_days = dinner_days

      profile_update.state = :complete

      profile_update.save
    else
      false
    end
  end

  protected
    VALIDATOR = Vanguard::Validator.build do
      validates_length_of :lunch_days,  :length => 1
      validates_length_of :dinner_days, :length => 1
    end
end
