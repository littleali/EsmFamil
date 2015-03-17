class Profile
  include Mongoid::Document
  field :fname, type: String
  field :lname, type: String
  belongs_to :user, class_name: 'User', inverse_of: :profile
  ## relation with room
  has_many :owned_rooms , class_name: 'Room' , inverse_of: :admin
  has_and_belongs_to_many :playing_rooms , class_name: 'Room' , inverse_of: :players

end
