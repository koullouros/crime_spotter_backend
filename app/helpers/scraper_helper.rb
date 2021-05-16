require 'open-uri'
require 'nokogiri'
require 'json'
require 'rest-client'

module ScraperHelper

  def google_scraper(query)
    # Scrapes Google News for ten articles related to a given query
    return nil if query.nil?
    response = Nokogiri::HTML(URI.open("https://www.google.com/search?q=#{query}&tbm=nws&source=lnt&tbs=sbd:1"))
    # Selects div containing individual articles, steps through children to extract article link.
    urls = response.xpath('//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[1]/*[1]/@href')
    # Same as above but selects title.
    titles = response.xpath('//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[1]/*[1]/*[1]/*[1]/text()')
    # Same as above but selects description.
    description = response.xpath('//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[3]/*[2]/*[1]/*[1]/*[1]/text()|//div[@id="main"]/*[position() > 3 and position() < 14]/*[1]/*[3]/*[1]/*[1]/*[1]/*[1]/text()')
    articles = []
    urls.each_with_index do |url, index|
      # Removes excess around urls ("/url?q") and ("&sa..")
      url = url.to_s[7..]
      url = url.split('&sa')[0]
      articles.push(
        title: titles[index].to_s.force_encoding('ISO-8859-1').encode('UTF-8'),
        url: url.to_s,
        description: description[index].to_s.force_encoding('ISO-8859-1').encode('UTF-8')
      )
    end
    # Return the list of articles
    articles
  end

  def cse_scraper(query, source)
    # Uses provided CSE links from The Independent and The Guardian for news
    return nil if query.nil?
    begin
      if source == 'independent'
        url = "https://cse.google.com/cse/element/v1?rsz=10&num=10&hl=en&source=gcsc&gss=.uk&cselibv=323d4b81541ddb5b&cx=006663403660930254993:oxhge2zf1ro&q=#{query}&safe=off&cse_tok=#{Rails.cache.read("cse:independent")}&sort=date&exp=csqr,cc&callback=g"
      else # (source == Guardian)
        url = "https://cse.google.com/cse/element/v1?rsz=10&num=10&hl=en&source=gcsc&gss=.com&cselibv=323d4b81541ddb5b&cx=007466294097402385199:m2ealvuxh1i&q=#{query}&safe=off&cse_tok=#{Rails.cache.read("cse:guardian")}&as_oq=&sort=date&exp=csqr,cc&callback=g"
      end
      results = JSON.parse(RestClient.get(url)[10..-3])['results']
      raise if results.nil?
    rescue StandardError
      # If the there is an error, assume token is invalid
      # Retrieves the latest token needed for scraping The Independent or The Guardian, then caches it
      Rails.cache.write("cse:#{source}", refresh_cse_token(source))
      retry
    end
    articles = []
    results.each do |result|
      articles.push(
        title: result['titleNoFormatting'].to_s.force_encoding('ISO-8859-1').encode('UTF-8'),
        url: result['cacheUrl'].to_s,
        description: result['contentNoFormatting'].to_s.force_encoding('ISO-8859-1').encode('UTF-8')
      )
    end
    # Return the list of articles
    articles
  end

  # Refreshes CSE token for a given source
  def refresh_cse_token(source)
    if source == 'independent'
      return JSON.parse(RestClient.get('https://cse.google.co.uk/cse/cse.js?cx=006663403660930254993:oxhge2zf1ro')[5997..-3])['cse_token']
    end
    JSON.parse(RestClient.get('https://cse.google.co.uk/cse/cse.js?cx=007466294097402385199:m2ealvuxh1i')[5997..-3])['cse_token']
  end
end
