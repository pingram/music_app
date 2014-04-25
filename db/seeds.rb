# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Band.create!(name: "Green Day")

a1 = Album.create!(name: "International Superhits",
									band_id: b1.id,
									recording_type: "Studio")

t1 = Track.create!(name: "Minority",
									album_id: a1.id,
									is_bonus: false,
									lyrics: "Don't want to be a minority")
t2 = Track.create!(name: "Warning",
									album_id: a1.id,
									is_bonus: false,
									lyrics: "Say warning. Live without warning")