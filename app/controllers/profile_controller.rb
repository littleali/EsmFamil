class ProfileController < ApplicationController
  def edit

  end

  def show
  	if user_signed_in?
      @profile = current_user
    else
      redirect_to :new_user_registration
    end
  end

end
