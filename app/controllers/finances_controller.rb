class FinancesController < ApplicationController


	def show
		@root = Vertice::Vertice.find(params[:id])
	end

	def create
		user = current_user
		to = Vertice::Vertice.find(obj_params[:to])
		finality = Vertice::Vertice.find(obj_params[:finality])
		a = Edge::SendMoney.create(user, to, finality, obj_params[:value], obj_params[:description])
		redirect_to :back
	end

	def delete

	end

  private
	def obj_params
		params.require(:sendmoney).permit(:to, :value, :description, :finality)
	end
end
