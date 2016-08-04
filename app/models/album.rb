class Album < ActiveRecord::Base

  validates :title, :band_id, presence: true
  validates :album_type, inclusion: { in: ['live', 'studio']}

  belongs_to :band

  has_many :tracks,
    dependent: :destroy
end
