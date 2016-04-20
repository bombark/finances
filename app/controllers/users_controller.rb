class UsersController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@users = Vertice::Vertice.all("User")
			}
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == ""
					@users = Vertice::Vertice.all("User",query)
				elsif akk == "friends"
					@users = current_user.friends.all
				elsif akk == "followers"
					@users = current_user.followers.all
				end
			}
		end
	end

	def show
		if current_user.present? && current_user.id == params[:id]
			redirect_to "/home"
			return
		end


		respond_to do |format|
			@user = Vertice::Vertice.find(params[:id])
			format.html
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == "collections"
					@objects = @user.collections.all
				elsif akk == "groups"
					@objects = @user.groups.all
				elsif akk == "events"
					@objects = @user.events.all
				elsif akk == "followers"
					@objects = @user.followers.all_in

				end
			}
		end

	end

	def new

	end

	def edit
		@user = Vertice::Vertice.find(params[:id])
	end



	def create
		user = Vertice::User.new
		user.build(params[:user])
		user.create
		session[:user_id] = user.id;
		redirect_to "/home";
	end

end
