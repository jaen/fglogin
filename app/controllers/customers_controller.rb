class CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer

    @first_time = ProfileUpdateService.first_profile_update?(@customer)
    @updating_profile = ProfileUpdateService.is_updating_profile?(@customer)

    if (@subscription = @customer.subscription)
      @preferences = @subscription.preferences
      @lunches = @subscription.lunch
      @dinners = @subscription.dinner
      @extra_notes = @subscription.extra_notes
      @lunch_time = @subscription.lunch_time ? @subscription.lunch_time.strftime('%H:%M') : 'time unset'
      @dinner_time = @subscription.dinner_time ? @subscription.dinner_time.strftime('%H:%M') : 'time unset'
    end

    if (@address = @customer.address)
        @phone = @address.phone
    end
  end
end
