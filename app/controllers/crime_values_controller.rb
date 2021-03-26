class CrimeValuesController < ApplicationController
  before_action :set_crime_value, only: [:show, :update, :destroy]

  # GET /crime_values
  def index
    @crime_values = CrimeValue.all

    render json: @crime_values
  end

  # GET /crime_values/1
  def show
    render json: @crime_value
  end

  # POST /crime_values
  def create
    @crime_value = CrimeValue.new(crime_value_params)

    if @crime_value.save
      render json: @crime_value, status: :created, location: @crime_value
    else
      render json: @crime_value.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /crime_values/1
  def update
    if @crime_value.update(crime_value_params)
      render json: @crime_value
    else
      render json: @crime_value.errors, status: :unprocessable_entity
    end
  end

  # DELETE /crime_values/1
  def destroy
    @crime_value.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crime_value
      @crime_value = CrimeValue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crime_value_params
      params.require(:crime_value).permit(:crime_value)
    end
end
