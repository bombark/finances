class ProjectsController < ApplicationController
	def index
		@projects = Vertice::Vertice.all("Project")
	end

	def show
		@project = Vertice::Vertice.find(params[:id])
	end

	def new
	end

	def create
	end



end
