module ProfileUpdateService
  def self.first_profile_update?(customer)
    customer.profile_updates.empty? || customer.profile_updates.length == 1 && customer.profile_updates.last.state != 'applied'
  end

  def self.is_updating_profile?(customer)
    !customer.profile_updates.empty?  && customer.profile_updates.last.state != 'applied'
  end

  def self.get_profile_update(customer)
    last_profile_update = customer.profile_updates.last

    if !last_profile_update.present? || last_profile_update.present? && last_profile_update.state == 'applied'
      customer.profile_updates.create
    else
      last_profile_update
    end
  end

  def self.progress_profile_update(customer, update_form)
    profile_update = customer.profile_updates.last

    if profile_update.present? # && (profile_update.state != 'complete' || profile_update.state != 'applied')
      if update_form.execute(profile_update)
        true
      else
        false
      end
    else
      false
    end
  end

  def self.apply_profile_update(customer)
    profile_update = customer.profile_updates.last

    if profile_update.present? && (profile_update.state == 'complete')
      customer.transaction do
        subscription = customer.subscription || customer.create_subscription

        subscription.preferences.delete_all

        profile_update.track_ids.each do |track_id|
          subscription.preferences.create(:track_id => track_id)
        end

        address = customer.address || customer.create_address

        address.phone = profile_update.address.phone
        address.email = profile_update.address.email
        address.zip   = profile_update.address.zip

        subscription.lunch_days  = profile_update.lunch_days
        subscription.dinner_days = profile_update.dinner_days

        subscription.save && address.save && customer.save && profile_update.update_attributes(:state => 'applied')
      end
    else
      false
    end
  end
end
