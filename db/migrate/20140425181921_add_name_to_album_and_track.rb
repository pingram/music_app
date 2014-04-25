class AddNameToAlbumAndTrack < ActiveRecord::Migration
  def change
  	add_column :albums, :name, :string
  	add_column :tracks, :name, :string
  end
end
