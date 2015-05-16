class Game
  include Mongoid::Document
  before_create :set_default_names , :set_letter
  field :letter, type: String
  field :title , type: String
  field :start_time, type: DateTime
  field :stopped, type: Boolean, default: false
  field :first_stopped, type: Boolean, default: false
  field :judged, type: Boolean, default: false
  field :item_names, type: Array
  field :first_stop_player_id, type: String
  field :second_stop_player_id, type: String
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


  def is_first_stopped
    self.is_stopped
  end

  def is_stopped
    self.stopped
  end

  def finish_judge
    self.judged = true
  end

  def is_judged
    self.judged
  end

  def assign_judges
    paper_owners = self.papers.all.map {|obj| {:id =>obj.id, :owner => obj.owner, :paper_fields =>obj.paper_fields}}
    n = paper_owners.size
    paper_owners.each_with_index do |p,i|
      p[:paper_fields].each do |pf|
        pf.update(:first_judge => paper_owners[(i+1)%n][:owner], :second_judge => paper_owners[(i+2)%n][:owner])
      end
    end
  end

  private
    def set_default_names
      self.item_names = ["اسم" , "فامیل" , "شهر" , "کشور" , "خوراک" , "پوشاک"]
    end

    def set_letter

      letters = ['آ','ب','پ','ت','ث','ج','چ','ح',
                 'خ','د','ذ','ر','ز','ژ','س','ش',
                 'ص','ض','ط','ظ','ع','غ','ف','ق',
                 'ک','گ','ل','م','ن','و','ه','ی']
      self.letter = letters.sample
    end
end
