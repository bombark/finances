class GroupsController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@groups = Vertice::Vertice.all("Group")
			}
			format.json{

				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == ""
					@groups = Vertice::Vertice.all("Group",query)
				elsif akk == "mygroups"
					@groups = current_user.groups.all
				end
			}
		end
	end

	def show
		@group = Vertice::Vertice.find(params[:id])
		@objects = []
		@title = "Nao definido"
		if params[:akk] == "Project"
			@title="Projetos"
			@objects = @group.projects.all
		elsif params[:akk] == "Collection"
			@title="Coleções"
			@objects = @group.collections.all
		elsif params[:akk] == "Group"
			@title="Grupos"
			@objects = @group.sons.all
		elsif params[:akk] == "Member"
			@title="Membros"
			@objects = @group.members.all
		elsif params[:akk] == "Event"
			@title="Eventos"
			@objects = @group.events.all
		elsif params[:akk] == "Class"
			@title="Estatuto"
			@objects = @group.classes.all
		end

		respond_to do |format|
			format.html
			format.json{
				@classe = "Package:"+params[:akk];
			}
		end
	end

	def edit
		@group = Vertice::Vertice.find(params[:id])
	end


	def update
		group = Vertice::Vertice.find(params[:id])
		if (params[:akk]=="thumbnail")
			group.set_thumbnail_by_upload(params[:group][:bitstream])
		else
			group.name = params[:group][:name]
			group.description = params[:group][:description]
			group.acronym = params[:group][:acronym]
			group.update
		end
		redirect_to :back
	end


	def new

	end

	def create
		group = Vertice::Group.new.build(params[:group])
		group.create
		current_user.groups.add(group)
		redirect_to group.path
	end

	def destroy
		group = Vertice::Group.find(params[:id])
		group.destroy
		redirect_to "/groups"
	end


	def addsubgroup
		group = Vertice::Group.find(params[:id])
		subgroup = Vertice::Group.new.build(params[:post_data])
		subgroup.create
		group.sons.add(subgroup)
		redirect_to group.path
	end


	def members
		@group = Vertice::Vertice.find(params[:id])
		@members = @group.members
	end

	def collections

	end



	def addmember
		group = Vertice::Vertice.find(params[:id])
		group.members.add(current_user)
		redirect_to :back
	end


	def delmember
		group = Vertice::Group.find(params[:id])
		group.members.del_by_to(current_user)
		redirect_to :back
	end


	def addplace
		group = Vertice::Group.new(params[:id])
		place = Vertice::Vertice.find(params[:akk])
		group.add_place(place.id)
	end



	def addclasse
		group = Vertice::Vertice.find(params[:id])
		classe = Vertice::Classe.new.build(params[:classe])
		classe.create
		group.classes.add(classe)
		redirect_to classe.path
	end

	def addproject
		group = Vertice::Vertice.find(params[:id])
		project = Vertice::Project.new.build(params[:project])
		project.create
		group.projects.add(project)
		redirect_to project.path
	end

	def addevent
		group = Vertice::Group.new(params[:id])
		event = Vertice::Event.new.build(params[:event])
		event.create
		group.events.add(event)
		redirect_to event.path
	end


	def addcollection
		group = Vertice::Group.new(params[:id])
		collection = Vertice::Collection.new.build(params[:collection])
		collection.create
		group.collections.add(collection)
		redirect_to collection.path
	end


	def finances
		@group = Vertice::Vertice.find(params[:id])
	end


end
