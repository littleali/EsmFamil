class Game
  include Mongoid::Document
  field :title, type: String
  belongs_to :room, class_name: 'Room', inverse_of: :games
end
