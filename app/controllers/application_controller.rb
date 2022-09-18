class ApplicationController < ActionController::Base
  # before_action :authenticate_customer!,except: [:top,:about]
  # before_action :configure_permitted_parameters, if: :devise_controller?
  
  # def after_sign_in_path_for(resource)
  #   customer_path(current_customer)
  # end
  
  # def after_sign_out_path_for(resource)
  #   root_path
  # end
  
end
