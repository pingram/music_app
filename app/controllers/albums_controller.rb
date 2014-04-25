class AlbumsController < ApplicationController
	def index
		@albums = Album.where(band_id: params["band_id"])
		render :index
	end

	def show
		@album = Album.find(params[:id])
		render :show
	end

	def new
		@band_id = params["band_id"]
		@album = Album.new
		@recording_types = Album.all_recording_types
		render :new
	end

	def create
		@album = Album.new(album_params)
		if @album.save
			redirect_to album_url(@album)
		else
			flash.now[:errors] = @album.errors.full_messages
			render :new
		end
	end

	def edit
		@band_id = params[:id]
		@album = Album.find(params[:id])
		@recording_types = Album.all_recording_types
		fail
	end

	def update
		@album = Album.find(params[:id])
		if @album.update_attributes(album_params)
			redirect_to album_url(@album)
		else
			flash.now[:errors] = @album.errors.full_messages
			render :edit
		end
	end

	def destroy
		@album = Album.find(params[:id])
		if @album.nil?
			flash[:errors] = "Album was not found"
			redirect_to albums_url
		else
			@album.delete! #XXX use try to delete
			# add a notice
			redirect_to albums_url
		end
	end

	def album_params
		params.require(:album).permit(:name, :band_id, :recording_type)
	end
end
