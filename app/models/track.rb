class Track < ActiveRecord::Base
	validates :name, :album_id, presence: true
	validates :is_bonus, inclusion: { in: [true, false] }

	belongs_to :album
	has_many :bands, through: :album
end