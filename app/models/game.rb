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
  field :scored, type:Boolean ,default: false
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
    unless self.judged
      self.papers.each do |paper|
        paper.paper_fields.each do |pf|
          if pf.first_accept == nil || pf.second_accept == nil
            return false
          end
        end
      end
      self.judged = true
    end
    return self.judged
  end

  def assign_judges
    paper_owners = self.papers.all.map {|obj| {:id =>obj.id, :owner => obj.owner, :paper_fields =>obj.paper_fields}}
    paper_owners.each_with_index do |p,i|
      other_players = paper_owners.clone()
      other_players.delete_at(i)
      n = other_players.size
      p[:paper_fields].each_with_index do |pf, j|
        pf.update(:first_judge => other_players[(j)%n][:owner], :second_judge => other_players[(j+1)%n][:owner])
      end
    end
  end


  def calculate_score
    if is_judged && self.scored
      return
    end

    self.item_names.each do |item_name| 
      item_hash = Hash.new
      number_of_correct_answer = 0
      self.papers.each do |paper| 
        index = paper.paper_fields.find_index {|item| item.name == item_name}
        item_value = paper.paper_fields[index].value

        if item_value
          if item_hash.has_key? item_value
            item_hash[item_value] = item_hash[item_value] + 1
          else
            item_hash[item_value] = 1
          end
          if paper.paper_fields[index].is_accepted
            number_of_correct_answer += 1
          end
        end
      end

      self.papers.each do |paper| 
        index = paper.paper_fields.find_index {|item| item.name == item_name}
        pf = paper.paper_fields[index]
        if pf.is_accepted and pf.value
          if item_hash[pf.value] > 1
            pf.score = 5
          else
            pf.score = 10
          end
          bonus = self.papers.size - number_of_correct_answer
          pf.score = pf.score + bonus * 10
          pf.update
        else
          pf.update
        end
        paper.update_score
      end
    end
    self.scored = true
    self.update
    return
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
