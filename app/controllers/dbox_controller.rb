class DboxController < ApplicationController
	def index
		@dbox = Vertice::Vertice.all("Dbox")
	end

	def show
		@dbox = Vertice::Vertice.find(params[:id])
	end

	def edit
		@dbox = Vertice::Vertice.find(params[:id])
	end

	def new

	end

	def update
		@dbox = Vertice::Vertice.find(params[:id])
		@dbox.name = params[:dbox][:name] || ""
		@dbox.description = params[:dbox][:description] || ""
		@dbox.update
		redirect_to @dbox.path
	end

	def create
		dbox = Vertice::Dbox.new(params[:dbox])
		dst_name = SecureRandom.uuid+".jpg";
		path = File.join(Rails.root, "files/dbox", dst_name) #params[:user][:avatar].original_filename)
		File.open(path, "wb") do |f|
			f.write(params[:dbox][:bitstream].read)
		end
		dbox.file = dst_name
		dbox.save
		redirect_to :back
	end

	def destroy
		dbox = Vertice::Vertice.find(params[:id])
		dbox.destroy
		redirect_to "/dbox"
	end

	def addcomment
		params[:comment]["out"] = session[:user_id]
		params[:comment]["in"] = params[:id]
		comments = Edge::Comments.new(params[:comment])
		comments.save
		redirect_to :back
	end



	def file
		dbox = Vertice::Vertice.find(params[:id])
		send_file dbox.get_file_path, disposition: 'inline'
	end
end
