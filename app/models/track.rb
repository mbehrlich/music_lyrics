class Track < ActiveRecord::Base

  validates :album_id, :title, presence: true
  validates :track_type, inclusion: { in: ['bonus', 'regular'] }

  has_many :notes,
    dependent: :destroy

  belongs_to :album

  has_one :band,
    through: :album,
    source: :band
end
