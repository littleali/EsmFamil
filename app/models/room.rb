class Room
  include Mongoid::Document
  field :name, type: String
  field :capacity, type: Integer
  field :enabled, type: Mongoid::Boolean
  belongs_to :admin, class_name: 'User', inverse_of: :rooms
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :admin
  validates_numericality_of :capacity, less_than_or_equal_to: 12, greater_than: 3
end
