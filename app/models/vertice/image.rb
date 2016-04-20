    class Vertice::Image < Vertice::Dbox

        def create(classe=nil,sql="")
            sql += ","	if sql != ""
            sql += "width='#{@width}',height='#{@height}'"
            classe = classe || "Image"
            return super(classe, sql)
        end

        def set_file(upload)
            super(upload)
            self.create_thumbnail
            width,height = FastImage.size( self.filebox_get(@file) )
            @@db.command "UPDATE #{@id} SET width=#{width},height=#{height},thumbnail='#{@thumbnail}'"
        end


        def create_thumbnail
            if @file.nil?
                raise "No file to create a thumbnail"
            end

            @thumbnail  = @id+"."+@extension
            src = self.filebox_path
            dst  = self.filebox_thumbnail_url
            system("convert -resize x100 \"#{src}/#{@file}\" \"#{dst}\"")
        end

    end
