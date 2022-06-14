module Grammar
    class Rule 
        property head : String
        property body : String
        
        def initialize(@head = head, @body = body)
        end

        def to_s
            return "Rule: #{@head} => #{@body}"
        end
        
        
    end
end
