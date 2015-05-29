class PaperField
  include Mongoid::Document
  field :score, type: Integer, default: 0
  field :first_accept, type: Boolean
  field :second_accept, type: Boolean
  belongs_to :first_judge, class_name: 'Profile'
  belongs_to :second_judge, class_name: 'Profile'
  belongs_to :paper, class_name: 'Paper' , inverse_of: :paper_fields
  field :value, type: String
  field :name, type: String
  embedded_in :paper

  def is_accepted
  	return first_accept || second_accept || first_accept == nil || second_accept == nil
  end
end
