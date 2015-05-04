class Game
  include Mongoid::Document
  before_create :set_default_names
  field :title, type: String
  field :start_time, type: DateTime
  field :stopped, type: Boolean, default: false
  field :first_stopped, type: Boolean, default: false
  field :item_names, type: Array 
  belongs_to :room, class_name: 'Room', inverse_of: :games
  has_many :papers , class_name: 'Paper' , inverse_of: :game
  validates :title, :uniqueness => {:scope => :room_id}
  def is_starting
  	if self.start_time and not self.is_stopped and not self.is_running
  		return true
  	end
  	return false
  end

  def is_running
  	if self.start_time and not DateTime.now < start_time and not is_stopped
  		return true
  	end
  	return false
  end

  def stop
    self.stopped = true
  end

  def first_stopped
    self.first_stopped = true
  end

  def is_first_stopped
    self.is_stopped
  end

  def is_stopped
    self.stopped
  end

  private
    def set_default_names
      self.item_names = ["اسم" , "فامیل" , "شهر" , "کشور" , "خوراک" , "پوشاک"]
    end
end
