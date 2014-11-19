class TracksPreferencesForm < FormObject
  attribute :track_ids, Array[Integer]

  protected
    VALIDATOR = Vanguard::Validator.build do
      validates_presence_of :track_ids
    end
end
