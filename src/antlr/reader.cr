require "./rule"
require "./identifiers"
require "./antlr_exception"
require "../misc/stack"
module Grammar
    
    class Antlr
        
        property terminals : Set(String) 
        property nonterminals : Set(String)
        property grammar : Array(Grammar::Rule)
        # # class Reader
        
        def initialize(@grammar = grammar, @terminals = terminals, @nonterminals = terminals)
        end
        
        def self.from_file(path : String)
            
            lines : Array(String) = File.read_lines(path).map {|l| l.strip }.select {|l| l != "" && !l.nil? }
            local_grammar : Array(Grammar::Rule) = extract(lines)
            # local_grammar.each {|g| puts g.to_s}
            nonterminals = local_grammar.map {|g| g.head}.to_set
            stack = Stack(Grammar::Identifiers).new()
            local_grammar.each do |g| 
                body = g.body.split(/('\('|'\)'|\s)/).map {|b| b.strip} .select {|b| b !="" && !b.nil? }

                new_body : Array(String | Array(String)) = Array(String |  Array(String)).new()
                if body.includes? "|"
                    production = 0
                    while production < body.size
                        if body[production].starts_with? "("
                            stack.push Grammar::Identifiers::OPEN_BRACKET
                            sub_body : Array(String) = Array(String).new()
                            # production += 1
                   
                            while stack.peek == Grammar::Identifiers::OPEN_BRACKET && production < body.size 
                                sub_body << body[production]
                                if body[production].ends_with? ")"
                                    stack.pop
                                    production -= 1
                                end
                                production += 1
                            end
                            new_body << sub_body
                        else 
                            new_body << body[production]
                        end
                        production += 1
                    end
                else 
                    new_body += body
                end

                if new_body.includes? "->"
                index = new_body.index {|b| b == "->"}
                new_body = new_body[0...index]
                end

                puts "NEW #{new_body}"

                

        
                
            end
            
        end
        
        def self.from_string(string : String)
            lines : Array(String) = string.split("\n").map {|l| l.strip }.select {|l| l != "" && !l.nil? }
        end
        
        # private def self.build(lines : Array(String))
        #     this = self.new()
        # end
        
        private def self.extract(lines : Array(String)) : Array(Grammar::Rule)
            stack = Stack(Grammar::Identifiers).new()
            line = 0
            grammar = Array(Grammar::Rule).new()
            
            while line < lines.size
                # puts "#{line+1} #{lines[line]}"
                
                if lines[line].starts_with?("//")
                    line += 1
                    next
                elsif lines[line].starts_with?("/*")
                    # pp "Stack #{stack.stack}"
                    if(!lines[line].ends_with? "*/")
                        stack.push Grammar::Identifiers::COMMENT
                        
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
                    else
                        line += 1
                        next
                    end
                elsif lines[line].starts_with? "*/"   
                    if stack.peek != Grammar::Identifiers::COMMENT
                        Grammar::AntlrException.new(lines[line])
                    else 
                        stack.pop 
                    end
                    
                elsif lines[line].starts_with? "grammar"
                    # puts lines[line]
                    # elsif stack.size > 0 && stack[-1] == Grammar::Identifiers::COMMENT
                else 
                    if /^(\w+)\s*:\s+(.+(?=;$))/ =~ lines[line]
                        head = $1
                        productions = $2
                        grammar.push(Grammar::Rule.new(head, productions.strip))
                        puts "Grammar: #{head} => #{productions}"
                    elsif /^(.+(?=:)$)/ =~ lines[line]
                        head = $1
                        stack.push Grammar::Identifiers::BODY
                        
                        body = ""
                        line += 1
                        while stack.peek == Grammar::Identifiers::BODY && line < lines.size
                            # TODO: handle comments in body
                            if lines[line].ends_with? ";"
                                if /^:?(.+(?=;$))/ =~ lines[line]
                                    body += $1
                                end
                                
                                stack.pop
                                line-= 1
                            else 
                                if /^:/ =~ lines[line]
                                    body += lines[line][1..-1]
                                else 
                                    body += lines[line]
                                end
                            end
                            line += 1
                        end
                        
                        grammar.push(Grammar::Rule.new(head, body.strip))
                        
                    elsif !lines[line].includes? ":"
                        stack.push Grammar::Identifiers::HEAD
                        head = lines[line]
                        
                        body = ""
                        line += 1
                        while stack.peek == Grammar::Identifiers::HEAD && line < lines.size
                            # TODO: handle comments in body
                            if lines[line].starts_with? ":"
                                if /^:(.+(?=;$))/ =~ lines[line]
                                    body += $1
                                end
                                
                                stack.pop
                                line-= 1
                            end
                            line += 1
                        end
                        
                        stack.push Grammar::Identifiers::BODY
                        
                        while stack.peek == Grammar::Identifiers::BODY && line < lines.size
                            # TODO: handle comments in body
                            if lines[line].ends_with? ";"
                                if /^:?(.+(?=;$))/ =~ lines[line]
                                    body += $1
                                end
                                
                                stack.pop
                                line-= 1
                            else 
                                if /^:/ =~ lines[line]
                                    body += lines[line][1..-1]
                                else 
                                    body += lines[line]
                                end
                            end
                            line += 1
                        end
                        grammar.push(Grammar::Rule.new(head, body.strip))
                        
                    else
                        puts "Not Matched: `#{lines[line]}`"
                        
                    end
                    
                end
                line += 1
                if !stack.empty?
                    Grammar::AntlrException.new(lines[line])
                end
            end
            return grammar
        end
    end
end

x = Grammar::Antlr.from_file("/home/ryzen/Documents/grammar.cr/sample_grammars/antlr/moo.g4")
# 
# puts typeof(x)