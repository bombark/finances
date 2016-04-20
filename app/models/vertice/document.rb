module Vertice
    class Document < Dbox

        def set_file(upload)
            super(upload)
            self.create_thumbnail
        end

        def get_thumbnail_path
            url = filebox_get("thumbnail.png")
            if File.exist?( url )
                return url
            else
                return "files/defaults/dbox.png"
            end
        end

        def create_thumbnail
            if @file.nil?
                raise "No file to create a thumbnail"
            end

            src = self.filebox_path
            dst = self.filebox_thumbnail_url
            system("cd #{src}; convert -background white -alpha remove -resize x100 #{@file}[0] \"thumbnail.png\" ")
         end

    end
end
