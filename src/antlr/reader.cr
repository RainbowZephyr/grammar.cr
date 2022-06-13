require "./rule"
require "./identifiers"
require "./antlr_exception"
require "../misc/stack"
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
            stack = Stack(Grammar::Identifiers).new()
            line = 0
            
            while line < lines.size
                puts "#{line+1} #{lines[line]}"
                
                if lines[line].starts_with?("//")
                    line += 1
                    next
                elsif lines[line].starts_with?("/*")
                    # pp "Stack #{stack.stack}"
                    if(!lines[line].ends_with? "*/")
                        stack.push Grammar::Identifiers::COMMENT
                    end
                    line += 1
                    while stack.peek == Grammar::Identifiers::COMMENT && line < lines.size
                        if(lines[line].starts_with? "/*")
                            Grammar::AntlrException.new(lines[line])
                        end

                        if lines[line].ends_with? "*/"
                            stack.pop
                            line -= 1
                        end
                        line += 1
                    end
                    
                    
                elsif lines[line].starts_with? "grammar"
                    puts lines[line]
                # elsif stack.size > 0 && stack[-1] == Grammar::Identifiers::COMMENT
                else 
                    
                end
                line += 1
                if !stack.empty?
                    Grammar::AntlrException.new(lines[line])
                end
            end
            
        end
    end
end

x = Grammar::Antlr.from_file("/home/ryzen/Documents/grammar.cr/sample_grammars/antlr/moo.g4")
# 
# puts typeof(x)