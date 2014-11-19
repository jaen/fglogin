class PreferencesController < ApplicationController
  def edit
    @area_preferences_form = AreaPreferencesForm.new
    @day_preferences_form  = DayPreferencesForm.new
    # @area_preferences_form.valid?
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
      message = if form.is_a?(DayPreferencesForm)
        message = { :redirect => root_path }
      else
        {}
      end

      render :json => { :type => :success, :message => message }
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
end
