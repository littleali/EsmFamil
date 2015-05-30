class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    #Room
    if(user.profile != nil)
        can :create, Room
        can :index, Room
        can :show, Room  do |room| 
            room.is_private == false || room.players.include?(user.profile)
        end
        can :show_with_name, Room do |room| 
            room.is_private == false || room.players.include?(user.profile)
        end
        can :destroy, Room,  :admin_id => user.profile.id
        can :edit, Room, :admin_id => user.id
        can :update, Room, :admin_id => user.id
        can :kick_out, Room, :admin_id =>user.profile.id
        can :leave, Room
        can :join, Room, :is_private => false
        can :send_invitation, Room
        can :new_game, Room, :admin_id =>user.profile.id
        can :create_game, Room, :admin_id =>user.profile.id
        can :accept_invitation, Room
        can :reject_invitation, Room
        #can :start, Game, :room_name => user.profile.rooms
        can :show_papers, Game
        #Profile
        can :edit, Profile, :user_id => user.id
        can :show, Profile
        cannot :destroy, Profile
    end
  end
end
