class Game
  include Mongoid::Document
  field :title, type: String
  field :start_time, type: DateTime
  field :stopped, type: Boolean
  belongs_to :room, class_name: 'Room', inverse_of: :games
  has_many :papers , class_name: 'Paper' , inverse_of: :game

  validates :title, :uniqueness => {:scope => :room_id}
  def is_starting
  	if self.start_time and not self.is_stopped and not self.is_runing
  		return true
  	end
  	return false
  end

  def is_runing
  	if self.start_time and not DateTime.now < start_time and not is_stopped
  		return true
  	end
  	return false
  end

  def stop
    self.stopped = true
  end

  def is_stopped
    self.stopped
  end
end
