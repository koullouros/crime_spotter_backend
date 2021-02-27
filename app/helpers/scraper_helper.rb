require 'open-uri'
require 'nokogiri'

module ScraperHelper

  def google_scraper(query)

    html = URI.open("https://www.google.com/search?q=#{query}&tbm=nws&source=lnt&tbs=sbd:1")

    response = Nokogiri::HTML(html)

    #Selects div containing individual articles, steps through children to extract article link.
    urls = response.xpath('//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[1]/*[1]/@href')
    #Same as above but selects title.
    titles = response.xpath('//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[1]/*[1]/*[1]/*[1]/text()')
    #Same as above but selects description.
    description = response.xpath('//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[3]/*[2]/*[1]/*[1]/*[1]/text()|//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[3]/*[1]/*[1]/*[1]/*[1]/text()')

    articles = []

    urls.each_with_index do |url,index|
      #Removes excess around urls ("/url?q") and ("&sa..")
      url = url.to_s[7..]
      url = url.split("&sa")[0]

      articles.push(Article.new(titles[index], url, description[index]))
    end

    articles
  end

end

class Article
  def initialize(title, url, description)
    @title = title
    @url = url
    @description = description
  end

  def display
    puts "#{@title} | #{@url} | #{@description}"
  end
end




