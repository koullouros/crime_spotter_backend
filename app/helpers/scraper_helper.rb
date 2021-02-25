require 'open-uri'
require 'nokogiri'

require 'selenium-webdriver'

query = "cheese"

html = URI.open("https://www.google.com/search?q=#{query}&tbm=nws&source=lnt&tbs=sbd:1")

response = Nokogiri::HTML(html)

articles = response.at_css('[id="main"]')

#puts response
#puts '&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'

#puts response.xpath('//div[@id="main"]')

#Selects div containing individual articles, steps through children to extract article link.
urls = response.xpath('//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[1]/*[1]/@href')

titles = response.xpath('//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[1]/*[1]/*[1]/*[1]/text()')

puts titles

urls.each do |url|
  url = url.to_s[7..]
  url = url.split("&sa")[0]
  #puts url
end






