    class Vertice::Animation < Vertice::Dbox

        def create(classe=nil,sql="")
            classe = classe || "Animation"
            return super(classe, sql)
        end

end
