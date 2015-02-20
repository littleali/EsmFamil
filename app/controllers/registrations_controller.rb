class RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "لطفا نوشته را دوباره وارد کنید."      
      flash.delete :recaptcha_error
      # render :new
      redirect_to :new_user_registration
    end
  end
end