require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    doc = Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
  end

  def get_courses
    titles = self.get_page.css(".post h2")
  end

  def get_schedules
    schedule = self.get_page.css(".post .date")
  end

  def get_descriptions
    description = self.get_page.css(".post p")
  end

  def make_courses
    courses_array = []
    i = 0
    while i < self.get_courses.length
      courses_array << Course.new
      courses_array[i].title = self.get_courses[i].text
      courses_array[i].schedule = self.get_schedules[i].text
      courses_array[i].description = self.get_descriptions[i].text
      i += 1
    end
    courses_array
  end

end
