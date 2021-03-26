class CrimesController < ApplicationController
  before_action :set_crime, only: [:show, :update, :destroy]

  # GET /crimes
  def index
    @crimes = Crime.all

    render json: @crimes
  end

  # GET /crimes/1
  def show
    render json: @crime
  end

  # POST /crimes
  def create
    @crime = Crime.new(crime_params)

    if @crime.save
      render json: @crime, status: :created, location: @crime
    else
      render json: @crime.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /crimes/1
  def update
    if @crime.update(crime_params)
      render json: @crime
    else
      render json: @crime.errors, status: :unprocessable_entity
    end
  end

  # DELETE /crimes/1
  def destroy
    @crime.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crime
      @crime = Crime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crime_params
      params.require(:crime).permit(:location, :crime_types, :crime_values)
    end
end
