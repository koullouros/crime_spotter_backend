
class AnalyticsController < ApplicationController
  include AnalyticsHelper

  def update_database(location)
    puts get_analytics(location)
  end

end
