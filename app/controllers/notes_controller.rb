class NotesController < ApplicationController
	def index
		@notes = Note.where(track_id: params[:track_id])
		render :index
	end

	def show
		@note = Note.find(params[:id])
		render :show
	end

	def new
		@note = Note.new(track_id: params[:track_id])
		render :new
	end

	def create
		@note = Note.new(note_params)
		if @note.save
			redirect_to track_url(@note.track)
		else
			flash.now[:errors] = @note.errors.full_messages
			render :new
		end
	end

	def edit
		@note = Note.find(params[:id])
	end

	def update
		@note = Note.find(params[:id])
		if @note.update_attributes(note_params)
			redirect_to note_url(@note)
		else
			flash.now[:errors] = @note.errors.full_messages
			render :edit
		end
	end

	def destroy
		@note = Note.find(params[:id])
		if @note.nil?
			flash[:errors] = "Note was not found"
			redirect_to track_url(@note.track)
		else
			@note.delete #XXX use try to delete
			# add a notice
			redirect_to track_url(@note.track)
		end
	end

	def note_params
		params.require(:note).permit(:user_id, :track_id, :body)
	end
end
