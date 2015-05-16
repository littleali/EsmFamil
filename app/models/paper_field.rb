class PaperField
  include Mongoid::Document
  field :first_accept, type: Boolean
  field :second_accept, type: Boolean
  belongs_to :first_judge, class_name: 'Profile'
  belongs_to :second_judge, class_name: 'Profile'
  belongs_to :paper, class_name: 'Paper' , inverse_of: :paper_fields
  field :value, type: String
  field :name, type: String
end
