class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:password, :password_confirmation, :current_password)
    }
  end

  def controller_name(*args)
    format = args[0]
    name = @overriden_controller_name || super()
    case format
      when :css, 'css'
        "#{name.dasherize}-controller"
      else
        name
    end
  end

  def action_name(*args)
    format = args[0]
    case format
      when :css, 'css'
        "#{super().dasherize}-action"
      else
        super()
    end
  end

  def override_controller_name(name)
    @overriden_controller_name = name
  end

  def body_css_classes
    [controller_name(:css), action_name(:css)]
  end
  helper_method :body_css_classes
end
