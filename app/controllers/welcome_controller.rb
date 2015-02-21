class WelcomeController < ApplicationController
  def index
  	render 'welcome/index'
  end
  def signup
    redirect_to :new_user_registration
  end
end
