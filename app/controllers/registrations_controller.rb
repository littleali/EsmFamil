class RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha
      puts "Try to create"
      super
      redirect_to :new_user_registration
    else
      puts "Error in captcha"
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash[:alert] = "لطفا نوشته را دوباره وارد کنید."
      #flash.delete :recaptcha_error
      #render :new
      redirect_to :new_user_registration
    end
  end
end