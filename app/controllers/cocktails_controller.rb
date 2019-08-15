class CocktailsController < ApplicationController

  def index
    @cocktail_options = Ingredient.all.map { |c| [c.name, c.id]}
    if params[:query].present?
      @cocktails = Cocktail.joins(:ingredients).where(ingredients: { id: params[:query] })
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end
end
