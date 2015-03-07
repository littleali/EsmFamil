class Profile
  include Mongoid::Document
  field :fname, type: String
  field :lname, type: String
  belongs_to :user, class_name: 'User', inverse_of: :profile
end
