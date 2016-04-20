namespace :users do
	desc "Update users status"
	task :update => :environment do
		users  = Vertice::User.all_online

		fd = File.open("files/online.kml","w");
		fd.puts '<?xml version="1.0" encoding="UTF-8"?>'
		fd.puts '<kml xmlns="http://earth.google.com/kml/2.0" xmlns:atom="http://www.w3.org/2005/Atom">'
		fd.puts '<Document>'
		fd.puts '<name>Online Users</name>'
		fd.puts '<atom:author>'
		fd.puts '<atom:name>Neex</atom:name>'
		fd.puts '</atom:author>'
		fd.puts '<atom:link href="http://earthquake.usgs.gov"/>'
		fd.puts '<Folder>'

		for user in users
			fd.puts '<Placemark>'
			fd.puts '<Point>'
			fd.puts '<coordinates>-49.29082,-25.50395</coordinates>'
			fd.puts '</Point>'
			fd.puts '</Placemark>'
		end

		fd.puts '</Folder>'
		fd.puts '</Document>'
		fd.puts '</kml>'
		fd.close

	end
end
