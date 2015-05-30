class RoomMessage
  include Mongoid::Document
  field :message, type: String
  field :profile_id, type: String
  field :room_id, type: String
  field :created_at, type: DateTime
  # belongs_to :profile, class_name: 'Profile'
  # embedded_in :room_id
end
