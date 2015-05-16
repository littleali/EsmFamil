class Paper
  include Mongoid::Document
  after_create :initial_field_values
  belongs_to :game, class_name: 'Game', inverse_of: :papers
  belongs_to :owner, class_name: 'Profile', inverse_of: :papers
  embeds_many :paper_fields, class_name: 'PaperField'

  private
  	def initial_field_values
  		self.game.item_names.each do |name|
        pf = PaperField.new
        pf.paper = self
        pf.name = name
        pf.save
        # self.paper_fields<<pf
  		end
      self.update
 	end
 
end
