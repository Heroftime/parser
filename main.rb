# Main program
require_relative "parser"

default_view = ARGV[0]

# Create and initiate the parser
parser = Parser.new("webserver.log")

if default_view == "unique"
  puts "--- UNIQUE VIEWS PER PAGE ---"
  parser.get_total_page_unique_views()
else
  puts "--- TOTAL VIEWS PER PAGE ---"
  parser.get_total_page_views()
end
puts "------------------------------"
