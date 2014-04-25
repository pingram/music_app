class Album < ActiveRecord::Base
	ALL_RECORDING_TYPES = %w(Studio Live)

	validates :name, :band_id, :recording_type, presence: true
	validates :recording_type, inclusion: { in: ALL_RECORDING_TYPES }

	belongs_to :band
	has_many :tracks, dependent: :destroy

	def self.all_recording_types
		ALL_RECORDING_TYPES
	end
end
