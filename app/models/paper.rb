class Paper
  include Mongoid::Document
  after_create :initial_field_values
  belongs_to :game, class_name: 'Game', inverse_of: :papers
  belongs_to :owner, class_name: 'Profile', inverse_of: :papers
  field :item_values, type: Hash, default: Hash.new
  embeds_many :paper_fields, class_name: 'PaperField'

  private
  	def initial_field_values
  		self.item_values = Hash.new
  		self.game.item_names.each do |name|
        pf = PaperField.new
        pf.paper = self
        pf.save
  			self.item_values[name] =pf

  		end

      self.update
  	end
 
end
