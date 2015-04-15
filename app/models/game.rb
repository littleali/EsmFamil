class Game
  include Mongoid::Document
  field :title, type: String
  belongs_to :room, class_name: 'Room', inverse_of: :games
  has_many :papers , class_name: 'Paper' , inverse_of: :game

  validates :title, :uniqueness => {:scope => :room_id}
end
