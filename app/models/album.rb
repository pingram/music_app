class Album < ActiveRecord::Base
	validates :name, :band_id, :recording_type, presence: true
	validates :recording_type, inclusion: { in: %w(Studio Live) }

	belongs_to :band
	has_many :tracks, dependent: :destroy
end
