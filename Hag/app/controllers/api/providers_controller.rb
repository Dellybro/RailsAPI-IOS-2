module API
	class ProvidersController < ApplicationController
		before_action :authenticate, only: [:update, :destroy, :add_service]
    	before_action :authenticate_signin, only: [:signin]
    	before_action :addClient, only: [:acceptRequest]

		def signin
	      	if request.get?
	        	if params[:email] && params[:password]
	          		render :json => Provider.find_by(email: params[:email]).to_json(:include => [:services, :requests, :client_relations]), status => 201
	        	end
	     	end
	    end

	    def index
		    if request.get?
		  		@providers = Provider.all
		  		if email = params[:email]
		  			@providers = @providers.where(email: email)
		  		end
		    	render :json => @providers.to_json(:include => [:services, :requests, :client_relations]), :status => 201
      		end
		end

		def addClient
			@provider = Provider.find_by(id: params[:message][:provider_id])
			if @provider.client_relations.find_by(client_id: params[:message][:client_id])
				#do nothing
			else
				@newRelation = @provider.client_relations.new(client_relations_params)
				@newRelation.save
			end
		end

		def add_service
			if request.post?
				if params[:service]
					if @provider = Provider.find_by(unique_id: params[:provider][:id])
						begin 
							@provider.services.create!(service_params)
							jm = JsonMessage.new(:status => 201, message: "Service Added")
              				render :json => jm.to_json, :status => 201
              			rescue Exception => e
              				jm = JsonMessage.new(:status => 400, message: "Invalid service")
              				render :json => jm.to_json, :status => 400
              			end
              		else
              			jm = JsonMessage.new(:status => 400, message: "You weren't found")
              			render :json => jm.to_json, :status => 400
              		end
              	end
			end
		end

		def index_services
			if request.get?
				if @provider = Provider.find_by(unique_id: params[:provider][:id])
					render :json => @provider.services.to_json, status => 201
				else
					jm = JsonMessage.new(:status => 400, message: "Nothing found")
              		render :json => jm.to_json, :status => 400
              	end
            end
		end

		def acceptRequest
			if request.post?
				if @provider = Provider.find_by(id: params[:message][:provider_id])
					if @client = Client.find_by(id: params[:message][:client_id])
						begin
							Message.create!(message_params)
							@provider.requests.find_by(client_id: params[:request][:client_unique]).destroy
							Message.last.notes.create(notes_params)
              				jm = JsonMessage.new(:status => 201, message: "Message Sent")
              				render :json => jm.to_json, :status => 201
              			rescue Exception => e
              				jm = JsonMessage.new(:status => 401, message: "exception caught")
              				render :json => jm.to_json, :status => 401
              			end
              		else
              			jm = JsonMessage.new(:status => 404, message: "Client doesn't exist")
              			render :json => e.to_json, :status => 404
					end
				else
					jm = JsonMessage.new(:status => 404, message: "You don't exist")
              		render :json => e.to_json, :status => 404
				end
			end
		end


		private
		#params
		def service_params
			params.require(:service).permit(:type)
		end
		def message_params
			params.require(:message).permit(:user_id, :provider_id, :client_id, :messageTitle)
		end
		def notes_params
			params.require(:note).permit(:message_id, :user_unique_id, :message)
		end
		def client_relations_params
			params.require(:message).permit(:provider_id, :client_id)
		end

		def get_error(user)
		    error_str = ""

		      user.errors.each{|attr, msg|           
		        error_str += "#{attr} - #{msg},"
		    }
		    e = JsonMessage.new(:status => 422, :message => error_str)
			render :json => e.to_json, :status => 422
    	end
	    #protecedMethods
		  protected

	      #render_unauthorized
	      def authenticate_signin
	        Provider.authenticate(params[:email], params[:password]) || render_unauthorized
	      end

	      def authenticate
	        authenticate_basic_auth || render_unauthorized
	      end

	      def render_unauthorized
	        self.headers['WWW-Authenticate'] =  'Basic realm="Providers"'
	        e = JsonMessage.new(:status => 400, :message => "User not authenticated")
	        render :json => e.to_json, status => 400
	      end

	      def authenticate_basic_auth
	        authenticate_or_request_with_http_token('Provider') do |token, options|
	          #string = "#{username}:#{password}".force_encoding("ISO-8859-1").encode("UTF-8")
	        	return Provider.find_by(auth_token: token)
	     	end
	  	  end
    end
end