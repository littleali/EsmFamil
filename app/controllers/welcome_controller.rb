class WelcomeController < ApplicationController
  def index
    @rooms = Room.any_of( {:_id.in => current_user.profile.playing_rooms.map{ |u| u._id.to_s}}, {:is_private => false })
  	render 'welcome/index'
  end
  def home
    if user_signed_in?
      @rooms = Room.any_of( {:_id.in => current_user.profile.playing_rooms.map{ |u| u._id.to_s}}, {:is_private => false })
      render 'welcome/index'
    else
      redirect_to :new_user_registration
    end
  end

  def test

  end

end
