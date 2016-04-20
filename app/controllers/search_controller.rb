class SearchController < ApplicationController
	def index
		qry = params[:qry] || ""
		@results = Dbnode.search_index(qry)
	end
end
