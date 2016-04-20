namespace :db do
	desc "Create database"
	task :migrate do
	    conn  = Neex::Application.database

		# CRIAR O INDEX EM PLACE!!!!!!!!!!!!!!!!!!!!!!!!!

		#if !conn.database_exists? "Neex"
		#	conn.create_database("Neex")
		#end


		create_class conn,"Person","V"
		create_class conn,"User","Person"

		create_class conn,"Place","V"
		create_class conn,"City","Place"
		create_class conn,"State","Place"
		create_class conn,"Country","Place"

		create_class conn,"Group","V"

		create_class conn,"Event","V"
		create_class conn,"Project","V"

		create_class conn,"Classe","V"
		create_class conn,"Method","V"

		create_class conn,"Institution","V"
		create_class conn,"University","Institution"

		create_class conn,"Subject","V"
		create_class conn,"Language","Subject"

		create_class conn,"Collection","V"


		create_class conn,"Dbox","V"
		create_class conn,"Image","Dbox"
		create_class conn,"Document","Dbox"
		create_class conn,"Audio","Dbox"
		create_class conn,"Animation","Dbox"
		create_class conn,"Weburl","Dbox"

		create_class conn,"hasClasse","E"
		create_class conn,"hasCollection","E"
		create_class conn,"hasDbox","E"
		create_class conn,"hasEvent","E"
		create_class conn,"hasFriend","E"
		create_class conn,"hasGroup","E"
		create_class conn,"hasMember","E"
		create_class conn,"hasMethod","E"
		create_class conn,"hasRequest","E"
		create_class conn,"hasProject","E"
		create_class conn,"hasSon","E"


		create_class conn,"followsUser","E"
		create_class conn,"followsCollection","E"
		create_class conn,"followsGroup","E"

		create_class conn,"isAbout","E"
		create_class conn,"localizedIn","E"
		create_class conn,"comments","E"
		create_class conn,"sendMoney","E"

		FileUtils.mkdir_p "files/thumbnails"
		FileUtils.mkdir_p "files/users"
	end
end

def create_class(conn, name,extends)
	if !conn.class_exists?(name)
		puts "Creating class #{name}"
		conn.create_class name,{:extends=>extends}
	end
end
