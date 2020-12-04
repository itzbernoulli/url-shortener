class ScraperJob < ApplicationJob
    queue_as :default
  
    require 'open-uri'
    require 'nokogiri'
  
    def perform(link_id)
      begin
        link = Link.find_by_id(link_id)
        html = URI.open(link.url)
      
        doc = Nokogiri::HTML(html)
        title = doc.css('head title').text
        link.update_attribute(:title, title)
      rescue => exception
        link.update_attribute(:title, "Error recovering title")
      end

    end
  end