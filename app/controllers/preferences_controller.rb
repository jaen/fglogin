class PreferencesController < ApplicationController
  before_filter :set_customer

  def edit
    @profile_update = ProfileUpdateService.get_profile_update(@customer)
    @step = @profile_update.state

    @area_preferences_form = AreaPreferencesForm.new(:email => @customer.email)
    @day_preferences_form  = DayPreferencesForm.new
  end

  def update
    form = if track_preferences_params.present?
      TracksPreferencesForm.new(track_preferences_params)
    elsif area_preferences_params.present?
      AreaPreferencesForm.new(area_preferences_params)
    elsif day_preferences_params.present?
      DayPreferencesForm.new(day_preferences_params)
    end

    if form && form.valid?
      if ProfileUpdateService.progress_profile_update(@customer, form)
        message = if form.is_a?(DayPreferencesForm)
          ProfileUpdateService.apply_profile_update(@customer)

          message = { :redirect => root_path }
        else
          {}
        end

        render :json => { :type => :success, :message => message }
      else
        render :json => { :type => :error, :errors => [] }
      end
    else
      render :json => { :type => :error, :errors => form.errors }
    end
  end

  protected
    def track_preferences_params
      @track_preferences_params ||= params.permit(:track_preferences => { :track_ids => [] })[:track_preferences]
    end

    def area_preferences_params
      @area_preferences_params ||= params.permit(:area_preferences => [:zipcode, :email, :phone])[:area_preferences]
    end

    def day_preferences_params
      @day_preferences_params ||= params.permit(:day_preferences => { :lunch_days => [], :dinner_days => [] })[:day_preferences]
    end

    def set_customer
      @customer = current_customer
    end
end
