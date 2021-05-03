require 'json'
require 'rest-client'

module ScraperHelper

  def cse_scraper(query, source)
    case source
    when 'independent'
      url = "https://cse.google.com/cse/element/v1?rsz=10&num=10&hl=en&source=gcsc&gss=.uk&cselibv=323d4b81541ddb5b&cx=006663403660930254993:oxhge2zf1ro&q=#{query}&safe=off&cse_tok=AJvRUv2r4sco5PEeSghxyFXMp7Z9:1619958360066&sort=date&exp=csqr,cc&callback=g"
    when 'guardian'
      url = "https://cse.google.com/cse/element/v1?rsz=small&num=4&hl=en&source=gcsc&gss=.com&cselibv=323d4b81541ddb5b&cx=007466294097402385199:m2ealvuxh1i&q=#{query}&safe=off&cse_tok=AJvRUv1KXgc7jxxAcCIs1CYqBZVc:1619958488164&as_oq=&sort=date&exp=csqr,cc&callback=g"
    else # Google
      url = "https://cse.google.com/cse/element/v1?rsz=10&num=10&hl=en&source=gcsc&gss=.uk&cselibv=323d4b81541ddb5b&cx=006663403660930254993:oxhge2zf1ro&q=#{query}&safe=off&cse_tok=AJvRUv2r4sco5PEeSghxyFXMp7Z9:1619958360066&sort=date&exp=csqr,cc&callback=g"
    end
    results = JSON.parse(RestClient.get(url)[10..-3])['results']
    articles = []
    results.each do |result|
      articles.push(
        title: result['titleNoFormatting'].to_s.force_encoding('ISO-8859-1').encode('UTF-8'),
        url: result['cacheUrl'].to_s,
        description: result['contentNoFormatting'].to_s.force_encoding('ISO-8859-1').encode('UTF-8')
      )
    end
    articles
  end

end
