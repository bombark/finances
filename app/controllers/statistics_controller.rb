class StatisticsController < ApplicationController
	def index
		@all = Vertice::User.all_online
	end


end
