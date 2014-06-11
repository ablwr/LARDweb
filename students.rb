# students = 
# [{:name => "Some Name", 
#   :tag_line => "My tagline", 
#   :excerpt => "", 
#   :twitter => "@..."
#   }]

require_relative 'webscraper.rb'

def run()
  puts "Welcome to Flatiron School Students!"
  print "Loading..."

  command = ""
  scraper = Flatiron_Scraper.new()
  students = scraper.profile_grabber()
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
    when "help"
      puts "Usage - The following commands are available:"
      puts "    help    Displays this message"
      puts "    list    Lists all Flatiron School students"
      puts "    info    Displays additional information for a student"
      puts "    exit    Quits the program"
    when "info"
      puts "Which student would you like to know more about (name or number)?"
      student_selection = gets.chomp
      if student_selection =~ /\d*/ && student_selection.to_i <= students.size() && student_selection.to_i > 0
        student_selection = students[student_selection.to_i - 1][:name]
      end
      info = "Student not found; please consult student list using 'list'"
      students.each do |student|
        if student[:name] == student_selection
          info =  "Here's more information about #{student_selection}\n"
          info += "    Tag-line: #{student[:tag_line]}\n"
          info += "    Excerpt: #{student[:excerpt]}\n"
          info += "    Twitter: #{student[:twitter]}"
        else
        end
      end
      puts info
    else
    end
  end
end

run()