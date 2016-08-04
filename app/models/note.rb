class Note < ActiveRecord::Base

  validates :user_id, :track_id, :note, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
    
  belongs_to :track

end
