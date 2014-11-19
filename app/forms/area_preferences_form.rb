class AreaPreferencesForm < FormObject
  attribute :zipcode
  attribute :email
  attribute :phone

  def execute(profile_update)
    if profile_update.state == 'area' && valid?
      address = profile_update.address || profile_update.create_address

      address.zip   = zipcode
      address.email = email
      address.phone = phone

      profile_update.state = :day

      address.save && profile_update.save
    else
      false
    end
  end

  protected
    VALIDATOR = Vanguard::Validator.build do
      validates_format_of :zipcode, :format => /^\d{5}$/
      validates_format_of :email,   :format => /@/
      validates_format_of :phone,   :format => /[0-9\-()+]{8,}/
    end
end
