require "./rule"
require "./identifiers"

module Grammar
    
    class Antlr
        # property terminals : Set(String)
        # property nonterminals : Set(String)
        # property grammar : Array(Grammar::Rule)
        # # class Reader
        
        # def initialize(@terminals = terminals, @nonterminals = nonterminals)
        
        # end
        
        def self.from_file(path : String)
            
            lines : Array(String) = File.read_lines(path).map {|l| l.strip }.select {|l| l != "" && !l.nil? }
            
            extract(lines)
        end
        
        def self.from_string(string : String)
            lines : Array(String) = string.split("\n").map {|l| l.strip }.select {|l| l != "" && !l.nil? }
        end
        
        private def self.extract(lines : Array(String))
            puts "Lines #{lines}"
            stack = Array(Grammar::Identifiers).new()
            lines.each do |l| 
                handle_multiline_comments(l, stack)
                

                if !stack.empty?
                    raise "Not a valid Antlr grammar"
                end
            end
            
        end
        
        private def self.handle_multiline_comments(line : String, stack : Array)
            if(l.starts_with? "/*")
                if(!l.ends_with? "*/")
                    stack.push Grammar::Identifiers::COMMENT
                end
            end
            
            if(l.starts_with? "*/")
                if stack.empty?
                    raise "Not a valid Antlr grammar"
                elsif (stack[-1] == Grammar::Identifiers::COMMENT) 
                    stack.pop                        
                else
                    raise "Not a valid Antlr grammar"
                end
            end 
        end    

    end
end

x = Grammar::Antlr.from_file("/home/ryzen/Documents/grammar.cr/sample_grammars/antlr/comments.g4")
# 
# puts typeof(x)