class HomeController < ApplicationController
  def home
    render :json => {'test': "pog"}
  end
end
