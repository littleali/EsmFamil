class Profile
  include Mongoid::Document
  field :fname, type: String
  field :lname, type: String
  field :total_score, type: Integer , default:  0
  belongs_to :user, class_name: 'User', inverse_of: :profile
  ## relation with room
  has_many :owned_rooms , class_name: 'Room' , inverse_of: :admin
  has_many :papers , class_name: 'Paper' , inverse_of: :owner
  has_and_belongs_to_many :playing_rooms , class_name: 'Room' , inverse_of: :players
  has_and_belongs_to_many :pending_playing_rooms , class_name: 'Room' , inverse_of: :pending_players

  def add_score(paper_score)
    puts "&&&&&&&&&&&&&&&&&&"
    puts paper_score
    self.total_score = self.total_score + paper_score.to_i
  	self.update
  end
end
