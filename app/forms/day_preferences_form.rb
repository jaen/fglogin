class DayPreferencesForm < FormObject
  attribute :lunch_days,  Array[Symbol]
  attribute :dinner_days, Array[Symbol]

  protected
    VALIDATOR = Vanguard::Validator.build do
      validates_length_of :lunch_days,  :length => 1
      validates_length_of :dinner_days, :length => 1
    end
end
