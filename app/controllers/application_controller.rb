class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper #this is to ensure that helper methods
  # are also available in the controllers. By default helper methods are only
  # available in views.
end
