module API
	class InboxController < ApplicationController

		def create
			if request.post?
				if @message = Message.find_by(params[:message][:message_id])
					@message.notes.new(notes_params)
					if @message.notes.last.save
						jm = JsonMessage.new(status: 201, message: "Message Sent")
						render :json => jm.to_json, :status => 201
					else
						jm = JsonMessage.new(status: 201, message: "Message not Sent")
						render :json => jm.to_json, :status => 201
					end
				else
					jm = JsonMessage.new(status: 201, message: "Message not found")
					render :json => jm.to_json, :status => 201
				end
			end
		end

		def get_messages
			if request.get?
				if params[:provider]
					@messages = Message.where(provider_id: params[:provider][:id])
					render :json => @messages.to_json(:include => [:notes]), :status => 201
				elsif params[:client]
					@messages = Message.where(client_id: params[:client][:id])
					render :json => @messages.to_json(:include => [:notes]), :status => 201
				end
			end
		end

		private

		def notes_params
			params.require(:note).permit(:message_id, :user_unique_id, :message)
		end

	end
end