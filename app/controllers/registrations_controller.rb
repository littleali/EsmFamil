class RegistrationsController < Devise::RegistrationsController
  def create
    params[:user].update(:bdate => params[:date][:year].to_s + "-" + params[:date][:month].to_s + "-"+ params[:date][:day].to_s, :birthday => params[:date])
    if verify_recaptcha
      puts "Try to create"
      super
      #redirect_to :new_user_registration
    else
      puts "Error in captcha"
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash[:alert] = "لطفا نوشته را دوباره وارد کنید."
      #flash.delete :recaptcha_error
      render :new
      # redirect_to :new_user_registration
    end
  end
end