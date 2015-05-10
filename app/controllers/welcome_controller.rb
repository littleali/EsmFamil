class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	render 'welcome/index'
  end
  def home
    if user_signed_in?
      render 'welcome/index'
    else
      redirect_to :new_user_registration
    end
  end

  def test

  end

end
