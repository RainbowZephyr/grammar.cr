module Notation
    
    class Prefix
        
        def self.infix_to_prefix(string : String) : Array(String)
            atoms = string.split(/(\(|\)| \| |\s)/).map {|a| a.strip} .select {|a| !a.nil? && a!=""}.reverse
            return atoms
        end
        
    end
    
end
