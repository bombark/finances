class ThumbnailsController < ApplicationController
	def showupload
		send_file "files/thumbnails/#{params[:id]}", disposition: 'inline'
	end

	def showdefault
		send_file "app/assets/images/#{params[:id]}.png", type: 'image/png', disposition: 'inline'
	end

	def geomaps
		send_file "files/geomaps.json", disposition: 'inline'
	end

	def online
		send_file "files/online.kml", disposition: 'inline'
	end
end
