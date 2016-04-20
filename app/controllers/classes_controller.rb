class ClassesController < ApplicationController
	def index
		@classes = Vertice::Vertice.all("Classe")
	end

	def show
		@classe = Vertice::Vertice.find(params[:id])
	end

	def new
	end

	def create
	end


	def addclasse
		classe = Vertice::Vertice.find(params[:id])
		subclasse = Vertice::Classe.new.build(params[:classe])
		subclasse.create
		classe.sons.add(subclasse)
		redirect_to classe.path
	end

	def addmethod
		classe = Vertice::Vertice.find(params[:id])
		method = Vertice::Method.new.build(params[:method])
		method.create
		classe.methods.add(method)
		redirect_to classe.path
	end


	def thumbnail
		if File.exist?("files/thumbnails/#{params[:id]}")
			send_file "files/thumbnails/#{params[:id]}", type: 'image/jpeg', disposition: 'inline'
		else
			send_file "files/defaults/place.png", type: 'image/png', disposition: 'inline'
		end
	end


end
