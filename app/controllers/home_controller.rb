class HomeController < ApplicationController
	before_filter :authorize

	def index

		respond_to do |format|
			format.html{
				@user = current_user
			}
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == "groups"
					@objects = current_user.groups.all
				elsif akk == "events"
					@objects = current_user.events.all
				elsif akk == "collections"
					@objects = current_user.collections.all
				end
			}
		end
	end

	def preference
		@user = current_user
	end


	def update
		if (params[:akk]=="thumbnail")
			current_user.set_thumbnail_by_upload(params[:user][:bitstream])
		else
			current_user.name = params[:user][:name]
			current_user.update
		end
		redirect_to :back
	end


    def friends
        @friends = current_user.friends.all
    end

    def groups
        @objects = current_user.groups.all
        respond_to do |format|
            format.html
            format.json
        end
    end

	def finances
		@user = current_user
	end







	def addcollection
		collection = Vertice::Collection.new.build(params[:collection])
		collection.create
		current_user.collections.add(collection)
		redirect_to collection.path
	end

	def addevent
		event = Vertice::Event.new.build(params[:event])
		event.create
		current_user.events.add(event)
		redirect_to event.path
	end



	def lives
		place = Vertice::Vertice.find(params[:in])
		current_user.lives(place.id)
		redirect_to :back
	end

	def follows
		akk = Vertice::Vertice.find(params[:akk])
		class_name = akk.class.name
		if class_name == "Vertice::User"
			current_user.followers.add(akk)
		elsif class_name == "Vertice::Collection"
			current_user.favorites.add(akk)
		end
		redirect_to :back
	end

	def unfollows
		akk = Vertice::Vertice.find(params[:akk])
		class_name = akk.class.name
		if class_name == "Vertice::User"
			current_user.followers.del_by_to(akk)
		elsif class_name == "Vertice::Collection"
			current_user.favorites.del_by_to(akk)
		end
		redirect_to :back
	end

	def list
		if params[:akk] == "collections"
			@objects = current_user.collections.all
		elsif params[:akk] == "groups"
			@objects = current_user.groups.all
		elsif params[:akk] == "events"
			@objects = current_user.events.all
		end
		respond_to do |format|
			format.json
		end
	end


	def comments
		comment = Edge::Comments.new.build(params[:comment])
		current_user.comments(comment)
		redirect_to :back
	end

	def uncomments
		comment = Edge::Comments::find(params[:akk])
		current_user.uncomments(comment)
		redirect_to :back
	end


	def requests
		current_user.has_requested(params[:akk])
		redirect_to :back
	end

	def accepts
		request = Dbedge.find(params[:akk])
		current_user.accepts_request(request)
		redirect_to :back
	end

	def rejects
		request = Dbedge.find(params[:akk])
		current_user.rejects_request(request)
		redirect_to :back
	end


	def likes
		comment = Edge::Comments.find(params[:akk])
		current_user.likes_comment(comment)
		redirect_to :back
	end





	def collections
		@collections = current_user.collections.all
		respond_to do |format|
			format.html
			format.json
		end
	end









	def authorize
		if current_user.nil?
			redirect_to "/login"
		end
	end


end
