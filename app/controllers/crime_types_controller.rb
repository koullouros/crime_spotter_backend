class CrimeTypesController < ApplicationController
  before_action :set_crime_type, only: [:show, :update, :destroy]

  # GET /crime_types
  def index
    @crime_types = CrimeType.all

    render json: @crime_types
  end

  # GET /crime_types/1
  def show
    render json: @crime_type
  end

  # POST /crime_types
  def create
    @crime_type = CrimeType.new(crime_type_params)

    if @crime_type.save
      render json: @crime_type, status: :created, location: @crime_type
    else
      render json: @crime_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /crime_types/1
  def update
    if @crime_type.update(crime_type_params)
      render json: @crime_type
    else
      render json: @crime_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /crime_types/1
  def destroy
    @crime_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crime_type
      @crime_type = CrimeType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crime_type_params
      params.require(:crime_type).permit(:crime_name)
    end
end
