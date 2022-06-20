module Notation
    
    class Postfix
        
        def self.infix_to_postfix(string : String) : Array(String)
            atoms = string.split(/(\(|\)| \| |\s)/).map {|a| a.strip} .select {|a| !a.nil? && a!=""}.reverse
            return atoms
        end
        
    end
    
end
