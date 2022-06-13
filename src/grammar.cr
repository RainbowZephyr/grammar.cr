require "option_parser"

# TODO: Write documentation for `Grammar`
module Grammar
  VERSION = "0.1.0"

  # TODO: Put your code here
end



options = Hash(Symbol, String).new 
# options = {} of Symbol => String
OptionParser.parse do |parser|
    parser.banner = "Usage: grammar [arguments] file"
    
    parser.on("-t", "--type=type", "Grammar file type, supported: `antlr`") do |type|
        options[:type] = type
    end
    
    parser.on("-h", "--help", "Show this help") do
        puts parser
        exit
    end
    
    parser.invalid_option do |flag|
        STDERR.puts "ERROR: #{flag} is not a valid option."
        STDERR.puts parser
        exit(1)
    end
end

puts options

puts ARGV[-1]