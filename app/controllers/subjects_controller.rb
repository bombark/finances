class SubjectsController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@subjects = Vertice::Vertice.all("Subject")
			}
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == "languages"
					@subjects = Vertice::Vertice.all("Language",query)
				else
					@subjects = Vertice::Vertice.all("Subject",query)
				end
			}
		end
	end

	def show
		@subject = Vertice::Vertice.find(params[:id])
	end

	def new

	end

	def create
		subject = Vertice::Subject.new.build(params[:post_data])
		subject.create
		redirect_to subject.path
	end

	def destroy
		@subject = Vertice::Vertice.find(params[:id])
		mother = @subject.mother
		@subject.destroy
		if mother.present?
			redirect_to mother.path
		else
			redirect_to :back
		end
	end


	def addsub
		subject = Vertice::Vertice.find(params[:id])
		subsubject = Vertice::Subject.new.build(params[:post_data])
		subsubject.create
		subject.sons.add(subsubject)
		redirect_to subject.path
	end



end
