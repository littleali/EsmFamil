class Paper
  include Mongoid::Document
  belongs_to :game, class_name: 'Game', inverse_of: :papers
  belongs_to :profile, class_name: 'Profile', inverse_of: :papers
end
