class Room
  include Mongoid::Document
  field :name, type: String
  field :capacity, type: Integer
  field :enabled, type: Mongoid::Boolean
  field :is_private, type: Boolean, default: false
  has_and_belongs_to_many :players , class_name: 'Profile' , inverse_of: :playing_rooms
  belongs_to :admin, class_name: 'Profile', inverse_of: :owned_rooms
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :admin
  validates_numericality_of :capacity, less_than_or_equal_to: 12, greater_than: 2
  has_many :games , class_name: 'Game' , inverse_of: :room
end
