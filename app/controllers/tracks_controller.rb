class TracksController < ApplicationController
	def index
		@tracks = Track.where(album_id: params["album_id"])
		render :index
	end

	def show
		@track = Track.find(params[:id])
		render :show
	end

	def new
		@album_id = params["album_id"]
		@track = Track.new
		render :new
	end

	def create
		@track = Track.new(track_params)
		if @track.save
			redirect_to track_url(@track)
		else
			flash.now[:errors] = @track.errors.full_messages
			render :new
		end
	end

	def edit
		@album_id = params[:id]
		@track = Track.find(params[:id])
	end

	def update
		@track = Track.find(params[:id])
		if @track.update_attributes(track_params)
			redirect_to track_url(@track)
		else
			flash.now[:errors] = @track.errors.full_messages
			render :edit
		end
	end

	def destroy
		@track = Track.find(params[:id])
		if @track.nil?
			flash[:errors] = "Track was not found"
			redirect_to tracks_url
		else
			@track.delete! #XXX use try to delete
			# add a notice
			redirect_to tracks_url
		end
	end

	def track_params
		params.require(:track).permit(:name, :album_id, :is_bonus, :lyrics)
	end
end