class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  #https://getbootstrap.com/docs/4.0/components/alerts/
  def boostrap_alert_lookup(msg_type)
    puts msg_type
    if msg_type == 'notice'
      'info'
    elsif msg_type == 'alert'
      'warning'
    elsif msg_type == 'error'
      'danger'
    end
  end
  helper_method :boostrap_alert_lookup
end
