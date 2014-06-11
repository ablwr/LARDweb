require 'open-uri'
require 'nokogiri'
require 'pry'

# students = []
# [{:name => "Some Name", 
#   :tag_line => "My tagline", 
#   :excerpt => "", 
#   :image_url => "http://", 
#   :profile_url => "http://",
#   :profile_info => {}
#   }]

# html = open('http://ruby005.students.flatironschool.com/').read

# URLHacking

def name_grabber
profiles = []
  doc = Nokogiri::HTML(open("http://ruby005.students.flatironschool.com/").read)
  profiles << doc.search("h3 a").collect{|e| e.text.strip }
  profiles
end

#puts profiles

# Other way cool too
# while i < 10
#   next_page = docsearch("a.button.next").attribute("href")
#   doc = Nokogiri::HTML(open("http://newyork.craigslist.org/roo/#{next_page}"))
#   prices << doc.search("span.price").collect{|e| e.text.gsub("$","").to_i}
#   i+=1
# end





# [1,2].inject(0) do |total, element|
#   total + element
# end
