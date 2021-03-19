include ScraperHelper

class HomeController < ApplicationController
  def home
    
    data = google_scraper('test')

    puts '--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- '
    puts data[0].to_json
    puts '--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- '


    render json: data


    #<p>For testing purposes:</p>
    #<% google_scraper("test").each do |article| %>
    #<%= article.title %>
    #<br>
    # <%= article.description %>
    # <br>
    # <%= article.url %>
    # <br><br>


  end
end
