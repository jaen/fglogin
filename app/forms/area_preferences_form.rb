class AreaPreferencesForm < FormObject
  attribute :zipcode
  attribute :email
  attribute :phone

  protected
    VALIDATOR = Vanguard::Validator.build do
      validates_format_of :zipcode, :format => /^\d{5}$/
      validates_format_of :email,   :format => /@/
      validates_format_of :phone,   :format => /[0-9\-()+]{8,}/
    end
end
