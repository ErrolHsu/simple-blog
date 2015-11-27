class TodoEventsController < ApplicationController

	def create
		@todo_event = current_user.todo_events.build(todo_event_params)
		if @todo_event.save
			redirect_to user_path(current_user)
		else
			render 'users/show'	
		end
	end

	private
		def todo_event_params
			params[:todo_event].permit(:event, :description, :date, :stretch)
		end
end
