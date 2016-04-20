namespace :db do
	desc "Create index for words searchs"
	task :index do
		orientdb  = Neex::Application.database
		elastic   = Neex::Application.elastic

		#curl -XDELETE 'http://localhost:9200/neex'

		if elastic.indices.exists index:"neex"
			elastic.indices.delete index:"neex"
		end
		elastic.indices.create index:"neex"
#			body: {
#				settings: {
#					analysis: {
#						analyzer: {
#							default: {
#								tokenizer: "standard",
#								filter: ["standard", "asciifolding"]
#							}
#						}
#					}
#				}
#			}




		raw = orientdb.query("SELECT * FROM V",{:limit=>-1})
		for node in raw
			puts "#{node["@rid"]}  #{node["@class"]}"
			elastic.index index: 'neex', type: node["@class"], id: node["@rid"], body: { name: node["name"], description: node["description"] }
		end
		puts "FIM"
	end
end
