require 'open-uri'
require 'nokogiri'
require 'pry'

# students = 
# [{:name => "Some Name", 
#   :tag_line => "My tagline", 
#   :excerpt => "", 
#   :twitter => "@..."
#   }]

# each name we pull down is the value of the name key
# one hash per student, and put them in an array of hashes
class Flatiron_Scraper
  attr_reader :flatiron_url
  attr_reader :flatiron_doc

  def initialize
    @flatiron_url = "http://ruby005.students.flatironschool.com/"
    @flatiron_doc = Nokogiri::HTML(open(@flatiron_url).read)
    @students = []
  end

  def profile_grabber
    names = name_grabber(flatiron_doc)
    tags = tag_grabber(flatiron_doc)
    excerpts = excerpt_grabber(flatiron_doc)
    profile_urls = profile_url_grabber(flatiron_doc)
    twitter_accounts = []
    
    profile_urls.each do |url|
      twitter_accounts << twitter_grabber(url)
    end

    names.each_with_index do |student_name, index|
      @students << {:name => student_name} 
      @students[index][:excerpt] = excerpts[index]
      @students[index][:tag_line] = tags[index]
      @students[index][:twitter] = twitter_accounts[index]
    end
    return @students
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

  def twitter_grabber(url)
    url = flatiron_url + url
    doc = Nokogiri::HTML(open(url).read)
    twitter_handle = doc.search(".social-icons a")[0]["href"]
    twitter_handle.sub!("https://twitter.com/", "@").match(/@\w+/).to_s
  end
end