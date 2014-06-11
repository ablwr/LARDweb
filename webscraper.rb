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
  excerpts = excerpt_grabber(doc)
  names.each_with_index do |student_name, index|
    students << {:name => student_name} 
    students[index][:excerpt] = excerpts[index]
  end
  return students
end



def name_grabber(doc)
  profiles = [] 
  # Student names
  profiles = doc.search("h3 a").collect{|e| e.text.strip }
  return profiles
end

def excerpt_grabber(doc)
  excerpts = []
  excerpts = doc.search(".excerpt p" , ".Learning p").collect{|e| e.text.strip } 
  return excerpts
end



def tag_grabber
  profiles = []
  doc = Nokogiri::HTML(open("http://ruby005.students.flatironschool.com/").read)
  profiles = doc.search(".home-blog-post-meta").collect{|e| e.text.strip }
  tag_line = []
  profiles.each do |tag_name|
    tag_line << {:tag_line => tag_name} 
  end
  return tag_line
end




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

def profile_url_grabber
  profiles = []
  doc = Nokogiri::HTML(open("http://ruby005.students.flatironschool.com/").read)
  profiles = doc.search(".blog-thumb a").collect{|e| e.text.strip }
  profile_url = []
  profiles.each do |profile_url_name|
    profile_url << {:profile_url => profile_url_name} 
  end
  return profile_url
end


