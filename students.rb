# students = []
# [{:name => "Some Name", 
#   :tag_line => "My tagline", 
#   :excerpt => "", 
#   :image_url => "http://", 
#   :profile_url => "http://",
#   :profile_info => {}
#   }]

require_relative 'webscraper.rb'

def run()
  puts "Welcome to Flatiron School Students!"
  command = ""
  students = name_grabber()
  while command != "exit"
    puts "What would you like to do?"
    command = gets.chomp.downcase
    case command
    when "list"
      i = 1
      students.each do |hash|
        puts "#{i}. #{hash[:name]}"
        i += 1
      end
    else
    end
  end
end

run()