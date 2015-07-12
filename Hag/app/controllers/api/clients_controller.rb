module API
	class ClientsController < ApplicationController
		before_action :authenticate, only: [:update, :destroy]
    	before_action :authenticate_signin, only: [:signin]

    	def searchViewResult
    		if request.get?
    			@providers = Provider.all
				@providers = @providers.where(city: params[:search][:city].downcase) if params[:search][:city]
				@providers = @providers.where(state: params[:search][:state].downcase) if params[:search][:state]
				@providers = @providers.where(email: params[:search][:email].downcase) if params[:search][:email]
				@providers.select { |user|
					user.services.where(type: params[:search][:service].downcase) if params[:search][:service]
				}
				@providers = @providers.where(first_name: params[:search][:first_name].downcase) if params[:search][:first_name]
				
			
				render :json => @providers.to_json, status => 201
    		end
    	end

		def signin
			if request.get?
	        	if params[:email] && params[:password]
	          		@client = Client.find_by(email: params[:email])
	          		render :json => @client.to_json, status => 201
	        	end
	      	end
		end

		def createRequest
			if request.post?
				if @provider = Provider.find_by(unique_id: params[:request][:provider_id])
					@request = @provider.requests.new(requests_params)
					if @request.save(requests_params)
						jm = JsonMessage.new(status: 201, message: "Request Sent")
						render :json => jm.to_json, :status => 201
					else
						jm = JsonMessage.new(status: 400, message: "Request already pending...")
						render :json => jm.to_json, :status => 400
					end
				else
					jm = JsonMessage.new(status: 404, message: "User not found")
					render :json => jm.to_json, :status => 404
				end
			end
		end

		private

		#params methods
		def requests_params
			params.require(:request).permit(:client_id, :provider_id, :request_message)
		end

		#proctedMethods
		  protected

	      #authenticate basic, if returns false use
	      #render_unauthorized

	      def authenticate_signin
	        Client.authenticate(params[:email], params[:password]) || render_unauthorized
	      end

	      def authenticate
	        authenticate_basic_auth || render_unauthorized
	      end

	      def render_unauthorized
	        self.headers['WWW-Authenticate'] =  'Basic realm="Consumers"'
	        e = JsonMessage.new(:status => 400, :message => "User not authenticated")
	        render :json => e.to_json, status => 400
	      end

	      def authenticate_basic_auth
	        authenticate_or_request_with_http_token('Consumer') do |token, options|
	          #string = "#{username}:#{password}".force_encoding("ISO-8859-1").encode("UTF-8")

	          return Client.find_by(auth_token: token)
	        end
	      end
	end
end