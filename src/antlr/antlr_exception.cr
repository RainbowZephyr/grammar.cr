module Grammar
    class AntlrException < Exception
        
        def initialize(message : String)
            raise "Not a valid Antlr grammar `#{message}`"
            
        end
        
    end
    
end