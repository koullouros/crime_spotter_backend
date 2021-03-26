class CrimeController < ApplicationController
  include CrimeHelper

  def crime
    coordinates = request.query_parameters['poly']
    date = request.query_parameters['date']

    render json: crime_helper(coordinates, date)
  end

end
