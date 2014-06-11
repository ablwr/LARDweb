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

# each name we pull down is the value of the name key
# one hash per student, and put them in an array of hashes

def profile_grabber
  students = []
  doc = Nokogiri::HTML(open("http://ruby005.students.flatironschool.com/").read)
  names = name_grabber(doc)
  tags = tag_grabber(doc)
  excerpts = excerpt_grabber(doc)
  profile_urls = profile_url_grabber(doc)
  names.each_with_index do |student_name, index|
    students << {:name => student_name} 
    students[index][:excerpt] = excerpts[index]
    students[index][:tag_line] = tags[index]
  end
  return students
  #return profile_urls
end

def name_grabber(doc)
  profiles = doc.search("h3 a").collect{|e| e.text.strip }
  return profiles
end

def excerpt_grabber(doc)
  excerpts = doc.search(".excerpt p" , ".Learning p").collect{|e| e.text.strip } 
  return excerpts
end

def tag_grabber(doc)
  tags = doc.search(".home-blog-post-meta").collect{|e| e.text.strip }
  return tags
end

def profile_url_grabber(doc)  
  profile_urls = doc.search(".blog-thumb a").collect{|e| e["href"].strip }
  return profile_urls
end

 #to-do
def image_url_grabber
  profiles = []
  doc = Nokogiri::HTML(open("http://ruby005.students.flatironschool.com/").read)
  profiles = doc.search("src").collect{|e| e.text.strip }
  image_url = []
  profiles.each do |image_url_name|
    image_url << {:image_url => image_url_name} 
  end
  return image_url
end



#puts profile_grabber



