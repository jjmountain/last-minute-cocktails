class DosesController < ApplicationController

  def create
  end

  def destroy
    @dose = Dose.find(params[:id])
    if @dose.destroy
      redirect_to cocktail_path(@dose.cocktail)
    end
  end

  private

  def Dose_Params
  end
end
