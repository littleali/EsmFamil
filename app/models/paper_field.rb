class PaperField
  include Mongoid::Document
  field :first_accept, type: Boolean, default: false
  field :second_accept, type: Boolean, default: false
  belongs_to :first_judge, class_name: 'Profile'
  belongs_to :second_judge, class_name: 'Profile'
  embedded_in :paper, class_name: 'Paper' , inverse_of: :paper_fields
  field :value, type: String
end
