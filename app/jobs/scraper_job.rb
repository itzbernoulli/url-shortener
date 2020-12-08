class ScraperJob < ApplicationJob
    queue_as :default
  
    require 'open-uri'
    require 'nokogiri'
  
    def perform(url,slug)
      p '*************'
      p url
      p slug
      begin
        # link = Link.find_by(:id, link_id)
        # p link
        html = URI.open(url)
      
        doc = Nokogiri::HTML(html)
        title = doc.css('head title').text
        p title
        Link.find_by_slug(slug).update_column(:title, title)
      rescue => exception
        Link.find_by_slug(slug).update_column(:title, "Error recovering title")
      end

    end
  end