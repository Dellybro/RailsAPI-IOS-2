module API
	class UsersController < ApplicationController
		def create
			if request.post?
				if params[:provider]
					if(Client.find_by(email: params[:provider][:email]))
    					e = JsonMessage.new(:status => 422, :message => "Email taken by Client")
      					render :json => e.to_json, :status => 422
    				else#If Clients don't have email make provider than save
    					@provider = Provider.new(provider_params)
						if @provider.save #Than account created
							uniq = UniqueId.create!(user_id: @provider.id)
							@provider.update(:unique_id => uniq.id)
							message = JsonMessage.new(:status => 201, :message => "Account Created")
							render :json => message.to_json, :status => 201
						else
							err = get_error(@provider)
						end
					end
				elsif params[:client]#IF PARAM IS CLIENT START
					if(Provider.find_by(email: params[:client][:email]))
    					e = JsonMessage.new(:status => 422, :message => "Email taken by Client")
      					render :json => e.to_json, :status => 422
    				else#if providers dont have email
    					@client = Client.new(client_params)
    					if @client.save#Than account created
    						uniq = UniqueId.create!(user_id: @client.id)
							@client.update(:unique_id => uniq.id)
    						message = JsonMessage.new(:status => 201, :message => "Account Created")
							render :json => message.to_json, :status => 201
						else
							err = get_error(@client)
						end
					end
				else
					message = JsonMessage.new(:status => 400, :message => "Sent the wrong params")
					render :json => message.to_json, :status => 400
				end
			end
		end

		def show
			if request.get?
				if params[:client]
					@client = Client.find_by(id: params[:client][:id])
					render :json => @client.to_json, status => 201
				elsif params[:provider]
					@provider = Provider.find_by(id: params[:provider][:id])
					render :json => @provider.to_json(:include => [:services, :requests, :client_relations]), status => 201
				else
					jm = JsonMessage.new(status: 400, message: "Bad Request")
				 	render :json => jm.to_json, :status => 400
				end
			end
		end
		def show_with_unique
			if request.get?
				if params[:client]
					@client = Client.find_by(unique_id: params[:client][:unique_id])
					render :json => @client.to_json, status => 201
				elsif params[:provider]
					@provider = Provider.find_by(unique_id: params[:provider][:unique_id])
					render :json => @provider.to_json(:include => [:services, :requests, :client_relations]), status => 201
				else
					jm = JsonMessage.new(status: 400, message: "Bad Request")
				 	render :json => jm.to_json, :status => 400
				end
			end
		end



		private
		#create
		def provider_params
			params.require(:provider).permit(:first_name, :last_name, :email, :password, :bio, :city, :state, :updated_at, :propic, :zipcode, :address)
		end
		#create
		def client_params
			params.require(:client).permit(:first_name, :last_name, :email, :password, :bio, :city, :state, :updated_at, :propic, :zipcode, :address)
		end
		#create
		def get_error(user)
		    error_str = ""

		      user.errors.each{|attr, msg|           
		        error_str += "#{attr} - #{msg},"
		    }
		    e = JsonMessage.new(:status => 422, :message => error_str)
			render :json => e.to_json, :status => 422
    	end

	end
end
