class CrimeEntriesController < ApplicationController
  before_action :set_crime_entry, only: [:show, :update, :destroy]

  # GET /crime_entries
  def index
    @crime_entries = CrimeEntry.all

    render json: @crime_entries
  end

  # GET /crime_entries/1
  def show
    render json: @crime_entry
  end

  # POST /crime_entries
  def create
    @crime_entry = CrimeEntry.new(crime_entry_params)

    if @crime_entry.save
      render json: @crime_entry, status: :created, location: @crime_entry
    else
      render json: @crime_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /crime_entries/1
  def update
    if @crime_entry.update(crime_entry_params)
      render json: @crime_entry
    else
      render json: @crime_entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /crime_entries/1
  def destroy
    @crime_entry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crime_entry
      @crime_entry = CrimeEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crime_entry_params
      params.require(:crime_entry).permit(:location_id)
    end
end
