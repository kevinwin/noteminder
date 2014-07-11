class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  ## Commented out security below. Figure how to add in later.
  # protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    new_note_path
  end

  def after_sign_out_path_for(resource_or_scope)
    users_path
  end
 
end
